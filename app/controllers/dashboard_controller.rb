class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @dashboard = Dashboard.new(
      user: current_user, 
      start_date: params[:start_date],
      end_date: params[:end_date]
    )
    @presenter = DashboardPresenter.new(@dashboard, self)
  end
end