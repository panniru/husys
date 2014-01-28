class HomeController < ApplicationController
  def landing
  end

  def exam_centers_geo
    respond_to do |format|
      format.json do
        @exam_centers = ExamCenterDecorator.decorate_collection(ExamCenter.all)

        @map_data = GoogleMapProcessor.build_map_data(@exam_centers)
        render :json => @map_data
      end
    end
  end
end
