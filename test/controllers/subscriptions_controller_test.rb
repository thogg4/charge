require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @params = { number: '4111111111111111', product: products(:one).name, name: 'Babe Ruth', exp_year: '2020', exp_month: '10' }
  end

  test 'should create subscription on gateway success' do
    stub_request(:get, 'http://localhost:4567/validate').to_return(body: '{"paid": "true"}')
    post subscriptions_url, params: @params
    assert_equal(1, Subscription.count)
    assert_response :created
  end

  test 'should fail without correct params' do
    post subscriptions_url, params: {}
    assert_response :payment_required
  end

  test 'should fail if number is invalid' do
    post subscriptions_url, params: @params.merge!(number: '1234567890')
    assert_response :payment_required
  end

  test 'should fail on gateway failure' do
    stub_request(:get, 'http://localhost:4567/validate').to_return(body: '{"failure_message": "message"}')
    post subscriptions_url, params: @params
    assert_response :payment_required
  end

end
