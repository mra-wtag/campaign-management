class Investment < ApplicationRecord
  validates :investor_mail, :amount, :campaign_id, presence: true
  validates :investor_mail, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :investment_multiple_amount

  belongs_to :campaign
  
  private
  
  def investment_multiple_amount
    investment_multiple = campaign.investment_multiple
    currency = campaign.currency_code
    if amount % investment_multiple > 0
      errors.add(:amount, "Invalid. Amount Must be multiple of #{investment_multiple} #{currency}")
    end
  end
end
