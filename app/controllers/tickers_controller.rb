class TickersController < ApplicationController
  def index
    @tickers = Ticker.order(:symbol)
  end
end
