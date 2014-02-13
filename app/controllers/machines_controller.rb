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
      redirect_to exam_center_machines_path(@exam_center), notice: I18n.t(:success, :scope => [:machine, :create])
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:machine, :create]
      render "new"
    end
  end

  def update
    if @machine.update(machine_params)
      redirect_to exam_center_machines_path(@machine), notice: I18n.t(:success, :scope => [:machine, :update])
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:machine, :update]
      render "edit"
    end
  end

  def destroy
    if @machine.destroy
      redirect_to exam_center_machines_path(@exam_center), notice: I18n.t(:success, :scope => [:machine, :destroy])
    else
      flash[:fail] = I18n.t :fail, :scope => [:machine, :destroy]
      redirect_to exam_center_machines_path(@machine), error: I18n.t(:fail, :scope => [:machine, :destroy])
    end
  end

  def edit
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
