class HomeController < ApplicationController
  def landing
    @courses = Course.grouped_category
    @exam_centers = ExamCentersDecorator.decorate_collection(ExamCenter.all)
    @map_data = GoogleMapProcessor.build_map_data(@exam_centers)
    gon.gmap_data = @map_data.to_json
  end

  def exam_centers_geo
    respond_to do |format|
      format.json do
        @exam_centers = []
        ExamCenter.all.find_each do |center|
          @exam_centers << ExamCentersDecorator.decorate(center)
        end
        p @exam_centers
        @map_data = GoogleMapProcessor.build_map_data(@exam_centers)
        render :json => @map_data
      end
    end
  end
end
