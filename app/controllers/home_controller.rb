class HomeController < ApplicationController
  before_action :redirect_admin_home
  def index; end

  private

  def redirect_admin_home
    redirect_to admin_home_index_path if current_user&.admin?
  end
end
