class HistoryController < ApplicationController
  def index
    @all_transactions = current_user.transactions.sort
  end
end
