module API
  module Resources
    class Campaign < Grape::API
      resource :campaigns do
        desc 'Retrieve all campaigns'
        get do
          campaigns = FetchCampaign.call
          present paginate(Kaminari.paginate_array(campaigns)), with: API::Entities::Campaign
        end

        desc 'Retrieve campaign by id'
        params do
          requires :id,
                   type: String,
                   coerce_with: ->(input) { input&.strip },
                   validate_campaign: true
        end
        route_param :id do
          get do
            campaigns = ::Campaign.find_by(id: params[:id])
            present campaigns, with: API::Entities::CampaignWithInvestments
          end
        end
      end
    end
  end
end