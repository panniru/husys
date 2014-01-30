class ExamCentersController < ApplicationController
  before_action :load_resource, :only => [:show, :edit, :update, :destroy]
  def index
    page = params[:exam_center_page].present? ? params[:exam_center_page] : 1
    @centers = ExamCenter.paginate(:page => page)
    @map_data = GoogleMapProcessor.build_map_data(@centers)
    gon.gmap_data = @map_data.to_json
    #@centers= ExamCentersDecorator.decorate_collection(@centers)
  end

  def new
    @exam_center = ExamCenter.new
  end

  def create
    @exam_center = ExamCenter.create(exam_Center_params)
    if @exam_center.errors.present?
      @exam_center.errors.each do |key, message|
        if key.to_s == 'latitude' or key.to_s == 'longitude'
          flash.now[:error] = I18n.t :gmap_error, :scope => [:exam_center, :error]
        end
      end
      flash.now[:fail] = I18n.t :fail, :scope => [:exam_center, :create]
      render "new"
    else
      # @map_data = GoogleMapProcessor.build_map_data(@exam_center)
      # gon.gmap_data = @map_data.to_json
      flash.now[:success] = I18n.t :success, :scope => [:exam_center, :create]
      render "show"
    end
  end

  def show
    #@exam_center = ExamCentersDecorator.decorate(@exam_center)
  end

  private

  def exam_Center_params
    params.require(:exam_center).permit(:center_name, :address_line1, :address_line2, :city, :state, :country, :pin, :center_email, :phone)
  end

  def load_resource
    if params[:id].present?
      @exam_center = ExamCenter.find(params[:id])
      @map_data = GoogleMapProcessor.build_map_data(@exam_center)
      gon.gmap_data = @map_data.to_json
    end
  end


end
