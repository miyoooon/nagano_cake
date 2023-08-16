class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!, only: [:top]

  def top
    @orders = Order.all.page(params[:page]).per(10)
  end

  private

end
