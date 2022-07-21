module API
  module Entities
    class CampaignWithInvestments < API::Entities::Campaign
      expose :investments, with: API::Entities::Investment
    end
  end
end
