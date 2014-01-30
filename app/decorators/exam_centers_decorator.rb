class ExamCentersDecorator < Draper::Decorator
  delegate_all

  def exam_details
    address =[]
    address << address_line1
    address << address_line2
    address << city
    address << state
    address << country
    address << country
    address << center_email
    address << phone
    address.join("</br>")
  end

  def localtion
    "#{address_line1}, #{address_line2}"
  end

  def phone
    phone ? phone.present? : "--"
  end

  def email
    email ? email.present? : "--"
  end

end
