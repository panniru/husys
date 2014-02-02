class CustomFormBuilder < ActionView::Helpers::FormBuilder
  def error_messages
    return unless object.errors.any?
    object.errors.full_messages.join(" ")
  end
end
