class PortfoliosController < AuthController
  # GET /portfolios
  def index
    @portfolio = Portfolio.find_or_initialize_by(user_id: current_user.id)
  end

  # POST /portfolios
  def create
    @portfolio = Portfolio.find_or_initialize_by(user_id: current_user.id)
    if @portfolio.update(portfolio_params)
      @portfolio
    else
      render json: @portfolio.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def portfolio_params
    params.require(:portfolio).permit(sheet: %i[ticker note unitPrice number])
  end
end
