class ApplicationController < ActionController::Base
  before_action :set_variables

  def set_variables
    @nav_categories = Category.all.order(priority: :asc).limit(4)
  end
end
