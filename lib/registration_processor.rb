class RegistrationProcessor

  def self.prepare_grid(date, exam_center)
    grid = []
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
      grid << GridReport.new(:machine_id => machine.id, :slots => slot_count)
    end
    grid
  end

  def self.best_fit_machine(grid, duration)
    machine = nil
    best_count = 0
    grid.each do |report|
      if report.slots.count(duration) > best_count
        best_count = report.slots.count(duration)
        machine = report.machine_id
      end
    end
    machine
  end

  def self.matched_slots(grid, duration)
    slots = []
    grid.each do |report|
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
    attribute :slots
  end

end
