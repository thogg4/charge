class SubscriptionsController < ApplicationController

  def create
    @subscription_request = SubscriptionRequest.new(subscription_params)

    if @subscription_request.charge
      Subscription.create(product: @subscription_request.product)
      render json: { success: true }, status: :created
    else
      render json: { success: false, errors: @subscription_request.errors.full_messages }, status: :payment_required
    end
  end

  private

  def subscription_params
    params.permit(:product, :name, :number, :exp_year, :exp_month, :cvv, :city, :state, :postal_code)
  end
end
