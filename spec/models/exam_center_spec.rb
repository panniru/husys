require 'spec_helper'
require 'factory_girl_rails'

describe ExamCenter do
  before do
    @exam_center = FactoryGirl.build(:exam_Centers)
    #@exam_center = ExamCenter.new(@exam_center_attr)
  end

  it "should be a valid exam center with valid parameters" do
    @exam_center.should_be_valid
  end

  context "validation" do

  end
end
