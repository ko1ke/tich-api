class ChipsController < ApplicationController
  def create
    Stripe.api_key = ENV['STRIPE_API_KEY']
    success_url = "#{ENV['FRONT_END_BASE_URL']}\/payment?success=true"
    cancel_url = "#{ENV['FRONT_END_BASE_URL']}\/payment?canceled=true"

    @session = Stripe::Checkout::Session
               .create({
                         line_items: [{
                           price: ENV['STRIPE_PRICE_ID'],
                           quantity: 1
                         }],
                         mode: 'payment',
                         success_url: success_url,
                         cancel_url: cancel_url
                       })
  end
end
