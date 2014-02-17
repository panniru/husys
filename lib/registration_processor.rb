class RegistrationProcessor
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :date
  attr_accessor :exam_center
  attr_accessor :grid
  attr_accessor :slots_available

  def initialize(date, exam_center)
    self.date= date
    self.exam_center= exam_center
  end

  def prepare_grid
    self.grid = []
    self.slots_available = []
    exam_center.machines.each do |machine|
      start_times = machine.registrations.dated_on(date).order('exam_start_time').map do |reg|
        [reg.exam_start_time.strftime('%H.%M').to_i , reg.exam_end_time.strftime('%H.%M').to_i]
      end
      slots = Array.new(19, true)
      start_times.each do |time|
        (time[0] .. time[1]-1).each { |t| slots[t] = false }
      end
      last_false = 0
      slot_count = Array.new(19, 0)
      slots.each_with_index do |val, i|
        unless val
          slot_count[i] = 0
          last_false = i
        else
          (last_false+1 .. i).each {|index| slot_count[index] =  slot_count[index]+1 }
        end
      end
      self.slots_available << GridReport.new(:machine_id => machine.id, :machine_code => machine.machine_id, :slots => slots)
      self.grid << GridReport.new(:machine_id => machine.id, :machine_code => machine.machine_id, :slots => slot_count)
    end
  end

  def get_slots
    slots_available
  end

  def get_grid
    grid
  end

  def best_fit_machine(start_time, duration)
    machine = nil
    best_count = 0
    self.grid.each do |report|
      if report.slots[start_time.to_i] >= duration
        machine = report.machine_id
        break
      end
    end
    machine
  end

  def matched_slots(duration)
    slots = []
    self.grid.each do |report|
      slot = report.slots.index(duration)
      report.slots.each_with_index do |s, index|
        if s >= duration
          slots << index
        end
      end
    end
    slots
  end

  class GridReport
    include Virtus.model
    attribute :machine_id, Integer
    attribute :machine_code
    attribute :slots
  end

end
