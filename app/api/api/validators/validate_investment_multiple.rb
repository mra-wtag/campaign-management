class ValidateInvestmentMultiple < Grape::Validations::Base
  def validate_param!(attr_name, params)
    campaign_id = params['campaign_id']
    return unless campaign_id.present?

    campaign = Campaign.find_by(id: campaign_id)
    return unless campaign
    
    amount = params[attr_name]
    investment_multiple = campaign.investment_multiple
    currency = campaign.currency_code
    if amount < 1
      message = "Invalid. Investment Amount can't be less than #{investment_multiple} #{currency}"
      raise_error(attr_name, message)
    end
    return if params[attr_name] % investment_multiple == 0
    
    example = investment_multiple * 2
    message = "Invalid. Amount Must be multiple of #{investment_multiple} #{currency}."\
              "For Example: #{investment_multiple} #{currency} or #{example} #{currency} and so on..."
    raise_error(attr_name, message)
  end
  
  def raise_error(attr_name, message)
    fail Grape::Exceptions::Validation,
         params: [attr_name.capitalize],
         message: message
  end
end
