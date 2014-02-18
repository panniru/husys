class GoogleMapProcessor
  def self.build_map_data(centers)
    map_centers = centers.select{ |center| center.latitude.present? and center.longitude.present? }
    Gmaps4rails.build_markers(map_centers) do |center, marker|
      marker.lat center.latitude
      marker.lng center.longitude
      marker.infowindow "#{center.id}: #{center.full_address_html}"
    end
  end
end
