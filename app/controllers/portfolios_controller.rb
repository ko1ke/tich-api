class PortfoliosController < AuthController
  before_action :set_portfolio, only: %i[show update destroy]

  # GET /portfolios
  def index
    @portfolios = Portfolio.all
  end

  # GET /portfolios/1
  def show
    @portfolio
  end

  # POST /portfolios
  def create
    @portfolio = Portfolio.new(portfolio_params)

    if @portfolio.save
      @portfolio
    else
      render json: @portfolio.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /portfolios/1
  def update
    if @portfolio.update(portfolio_params)
      @portfolio
    else
      render json: @portfolio.errors, status: :unprocessable_entity
    end
  end

  # DELETE /portfolios/1
  def destroy
    @portfolio.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_portfolio
    @portfolio = Portfolio.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def portfolio_params
    params.permit(:ticker, :unit_price, :number, :note).merge(uid: uid)
    # params.require(:portfolio).permit(:ticker, :unit_price, :number, :note).merge(uid: uid)
  end
end
