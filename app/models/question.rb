class Question < ActiveRecord::Base

  validates :description, :presence => true
  validates :option_1, :presence => true
  validates :option_2, :presence => true
  validates :option_3, :presence => true
  validates :option_4, :presence => true

  belongs_to :course


  def xls_template(options)
    template_headers = ['description', 'option_1', 'option_2', 'option_3', 'option_4', 'answer']
    CSV.generate(options) do |csv|
      csv << attribute_names.select { |name| template_headers.include?name }
    end
  end
end
