class ValidateCampaign < Grape::Validations::Base
  def validate_param!(attr_name, params)
    campaign = Campaign.find_by(id: params[attr_name])
    return if campaign
    
    message = "Invalid. Please provide a valid Campaign Id"
    fail Grape::Exceptions::Validation,
         params: [attr_name.to_s.split('_').map(&:capitalize).join(' ')],
         message: message
  end
end
