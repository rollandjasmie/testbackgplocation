require 'stripe'
class ChargesController < ApplicationController
  before_action :authorized

    def new
      puts "errror card"
    end
    
    def create
#       Stripe::Customer.create({
#   description: 'My First Test Customer (created for API docs)',
# })
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']

      # Token is created using Stripe Checkout or Elements!
      # Get the payment token ID submitted by the form:
      token = params[:stripeToken]
      amount = params[:accompte]
      client = Client.find(params[:description])
      description = "client: #{client.nom} #{client.prenom}, tel: #{client.telephone}, email: #{client.email}"
      
      charge = Stripe::Charge.create({
        amount: (amount.to_i)*100,
        currency: 'eur',
        description: description,
        source: token,
      })
      render json: charge.paid
    
    rescue Stripe::CardError => e
      e.message
      render json: e.message
    end
    
end
