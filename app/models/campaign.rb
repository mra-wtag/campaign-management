class Campaign < ApplicationRecord
  before_validation :set_default_data
  validates :name,
            :target_amount,
            :investment_multiple,
            :investment_raised,
            :currency_code,
            :country_code,
            presence: true
  validates :country_code, length: { is: 2 }
  validates :currency_code, length: { is: 3 }
  
  def set_default_data
    self.currency_code = 'GBP'
  end
  
  def percentage_raised
    return 0.to_d.round(2) if investment_raised.zero?
    
    (target_amount / investment_raised).round(2)
  end
end
