class PortfoliosController < AuthController
  # GET /portfolios
  def index
    @portfolio = Portfolio.find_or_initialize_by(uid: current_user.uid)
  end

  # POST /portfolios
  def create
    @portfolio = Portfolio.find_or_initialize_by(uid: current_user.uid)
    if @portfolio.update_attributes(portfolio_params)
      @portfolio
    else
      render json: @portfolio.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def portfolio_params
    para = params.require(:portfolio).permit(:sheet).merge(uid: current_user.uid)
    if para[:sheet].present?
      sheet = JSON.parse(para[:sheet])
      sheet.map do |item|
        item.merge!({ "unitPrice": item['unitPrice'].to_f,
                      "number": item['number'].to_i })
      end
      para[:sheet] = sheet
    end
    para
  end
end
