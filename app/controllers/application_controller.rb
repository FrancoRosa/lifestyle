class ApplicationController < ActionController::Base
  before_action :set_variables

  def set_variables
    @nav_categories = Category.top(4)
  end
end
