class FundsController < ApplicationController
  def index; end

  def buy
    current_user.add_funds(usd_quantity)

    redirect_to root_path, notice: 'Funds added successfully!'
  end

  private

  def usd_quantity
    params.require(:usd_quantity).to_f
  end
end
