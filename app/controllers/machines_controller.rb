 class MachinesController < ApplicationController

  before_action :load_exam_center
  before_action :load_machine, :only => [:show, :edit, :update, :destroy]

  def index
    @machines = @exam_center.machines.order("id DESC")
  end

  def new
    @machine = @exam_center.new_machine
  end

  def create
    @machine = @exam_center.add_machine(machine_params)
    if @machine.save
      redirect_to exam_center_machines_path(@exam_center)
    else
      render "new"
    end
  end

  def update
    if @machine.update(machine_params)
      redirect_to exam_center_machines_path(@machine)
      else
      render "edit"
    end
  end

  private

  def load_exam_center
    @exam_center = ExamCenter.find(params[:exam_center_id])
  end

  def load_machine
    @machine = @exam_center.machines.find(params[:id])
  end

  def machine_params
    params.require(:machine).permit(:machine_id, :status)
  end

end
