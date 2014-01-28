class ExamCenter < ActiveRecord::Base

  geocoded_by :full_address   # can also be an IP address
  after_validation :geocode
  validates :center_name, :presence=> true
  validates :address_line1, :presence=> true

  def full_address
    address =[]
    address << self.address_line1
    address << self.address_line2
    address << self.city
    address << self.state
    address << self.country
    address.join(" ")
  end

end
