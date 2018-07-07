class SubscriptionRequest
  include ActiveModel::Model

  attr_accessor :product, :name, :number, :exp_year, :exp_month, :cvv, :city, :state, :postal_code

  validates :product, :number, :name, :exp_year, :exp_month, presence: true
  validate :number_passes_luhn

  def initialize(params)
    super(params)

    self.product = Product.find_by(name: self.product)
  end

  def number_passes_luhn
    if !Luhn.valid?(self.number)
      self.errors.add(:number, 'must pass luhn test')
    end
  end

  def charge
    return false unless self.valid?

    gateway = Gateway.new.create_subscription(
      amount: self.product.amount,
      name: self.name,
      number: self.number,
      exp_year: self.exp_year,
      exp_month: self.exp_month,
      cvv: self.cvv
    )

    gateway.errors.each { |error| self.errors.add(:gateway_error, error) }

    return false unless self.errors.empty?

    true
  end
end
