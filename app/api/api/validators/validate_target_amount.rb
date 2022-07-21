class ValidateTargetAmount < Grape::Validations::Base
  def validate_param!(attr_name, params)
    campaign_id = params['campaign_id']
    return unless campaign_id.present?

    campaign = Campaign.find_by(id: campaign_id)
    return unless campaign

    target_amount = campaign.target_amount
    investment_raised = campaign.investment_raised
    return if params[attr_name] + investment_raised <= target_amount

    currency = campaign.currency_code
    amount = target_amount - investment_raised
    message = "crossed the Target Amouont of this Campaign. Available investment amount is #{amount} #{currency}"
    fail Grape::Exceptions::Validation,
         params: [attr_name.capitalize],
         message: message
  end
end
