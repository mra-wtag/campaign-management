module API
  module Entities
    class InvestmentWithCampaign < API::Entities::Investment
      expose :campaign, with: API::Entities::Campaign
    end
  end
end
