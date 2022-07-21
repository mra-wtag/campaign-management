module API
  module Resources
    class Campaign < Grape::API
      desc 'Retrieve all campaigns'
      get :campaigns do
        campaigns = FetchCampaign.call
        present paginate(Kaminari.paginate_array(campaigns)), with: API::Entities::Campaign
      end
    end
  end
end