class Machine < ActiveRecord::Base

  validates :status, :presence => true
  validates :machine_id, :presence => true

  belongs_to :exam_center
  has_many :registrations

  scope :active, where(:status => "active")

end
