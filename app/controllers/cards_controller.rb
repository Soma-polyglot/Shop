class CardsController < ApplicationController
  require "payjp"

  def new 
  end

  def create 
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']

    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        description: 'test', 
        card: params['payjp-token'], 
        metadata: {user_id: current_user.id} 
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to done_signup_index_path
      else
        redirect_to action: "create"
      end
    end
  end

end
