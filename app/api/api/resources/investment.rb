module API
  module Resources
    class Investment < Grape::API
      desc 'Create a new investment'
      params do
        requires :user_email,
                 type: String,
                 allow_blank: false,
                 coerce_with: ->(input) { input&.strip },
                 regexp: URI::MailTo::EMAIL_REGEXP,
                 desc: 'Investor Email Address'
        requires :amount,
                 type: BigDecimal,
                 allow_blank: false,
                 validate_investment_multiple: true,
                 validate_target_amount: true,
                 desc: 'Investment Amount'
        requires :campaign_id,
                 type: String,
                 allow_blank: false,
                 validate_campaign: true,
                 desc: 'Campaign to Invest'
      end
      post :investments do
        investment = GenerateInvestment.call(permitted_params)
        present investment, with: API::Entities::InvestmentWithCampaign
      end
    end
  end
end