class PortfoliosController < AuthController
  # GET /portfolios
  def index
    @portfolio = Portfolio.find_or_initialize_by(uid: uid)
  end

  # POST /portfolios
  def create
    @portfolio = Portfolio.find_or_initialize_by(uid: uid)
    if @portfolio.update_attributes(portfolio_params)
      @portfolio
    else
      render json: @portfolio.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def portfolio_params
    params.permit(:sheet).merge(uid: uid)
    # params.require(:portfolio).permit(:ticker, :unit_price, :number, :note).merge(uid: uid)
  end
end
