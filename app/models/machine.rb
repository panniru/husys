class Machine < ActiveRecord::Base

  validates :status, :presence => true

  belongs_to :exam_center
  has_many :registrations

end