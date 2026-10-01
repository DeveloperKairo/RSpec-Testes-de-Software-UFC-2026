class DashboardController < ApplicationController
  before_action :authenticate_request!

  def index
    @projects = current_user.projects.includes(:tasks)
  end
end
