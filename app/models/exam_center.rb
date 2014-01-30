WillPaginate.per_page = 10
class ExamCenter < ActiveRecord::Base

  geocoded_by :full_address   # can also be an IP address
  before_validation :geocode
  validates :center_name, :presence=> true
  validates :address_line1, :presence=> true
  validates :latitude, :numericality => true
  validates :longitude, :numericality => true

  def address_list
    address =[]
    address << self.address_line1
    address << self.address_line2
    address << self.city
    address << self.state
    address << self.country
  end

  def full_address
    address_list.join(" ")
  end

  def full_address_html
    address_list.join("<br/>")
  end

  private
end
