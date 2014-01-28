class AutoSearchController < ApplicationController
  skip_authorization_check
  autocomplete :course, :category, :full => true, :scopes => [:distinct_category]
  autocomplete :course, :sub_course, :full => true, :scopes => [:distinct_sub_course]

  def get_autocomplete_items(parameters)
    items = super(parameters)
  end
end
