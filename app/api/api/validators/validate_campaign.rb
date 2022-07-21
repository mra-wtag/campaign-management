class ValidateCampaign < Grape::Validations::Base
  def validate_param!(attr_name, params)
    campaign_id = params[attr_name]
    return unless campaign_id
    
    campaign = Campaign.find_by(id: campaign_id)
    return if campaign
    
    message = "Invalid. Please provide a valid Campaign Id"
    fail Grape::Exceptions::Validation,
         params: [attr_name.to_s.split('_').map(&:capitalize).join(' ')],
         message: message
  end
end
