class Campaign < ApplicationRecord
  before_validation :set_default_data
  validates :name,
            :target_amount,
            :investment_multiple,
            :investment_raised,
            :currency_code,
            :country_code,
            presence: true
  validates_length_of :country_code, minimum: 2, maximum: 2, allow_blank: false
  validates_length_of :currency_code, minimum: 3, maximum: 3, allow_blank: false
  
  has_many :investments, dependent: :destroy
  
  def set_default_data
    self.currency_code = 'GBP'
  end
  
  def percentage_raised
    return 0.to_d.round(2) if investment_raised.zero?
    
    ((investment_raised / target_amount) * 100).round(2)
  end
end
