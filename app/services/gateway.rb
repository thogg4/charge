class Gateway
  include HTTParty

  base_uri 'localhost:4567'
  basic_auth 'billing', 'gateway'

  attr_accessor :errors

  def initialize
    @errors = []
  end

  def create_subscription(amount:, name:, number:, exp_year:, exp_month:, cvv: nil)
    response = self.class.get('/validate')
    parsed = response.parsed_response

    raise GatewayError unless response.success?

    @errors << response['failure_message'] if response['failure_message']

    self
  rescue GatewayError
    retry
  end

  class GatewayError < StandardError
  end
end
