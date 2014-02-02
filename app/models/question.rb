class Question < ActiveRecord::Base

  validates :description, :presence => true
  validates :option_1, :presence => true
  validates :option_2, :presence => true
  validates :option_3, :presence => true
  validates :option_4, :presence => true

  belongs_to :course


end
