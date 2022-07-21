class GenerateInvestment
  def self.call(permitted_params)
    user_mail = permitted_params[:user_email]
    amount = permitted_params[:amount]
    campaign_id = permitted_params[:campaign_id]
    campaign = Campaign.find(campaign_id)
    ActiveRecord::Base.transaction do
      investment = Investment.create!(investor_mail: user_mail, amount: amount, campaign: campaign)
      total_amount = campaign.investments.map(&:amount).sum
      campaign.update!(investment_raised: total_amount)
      investment
    end
  end
end