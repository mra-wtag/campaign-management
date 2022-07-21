module API
  module Entities
    class Campaign < Grape::Entity
      expose :id
      expose :name
      expose :image_url
      expose :percentage_raised
      expose :target_amount
      expose :sector
      expose :country_code
      expose :investment_multiple
    end
  end
end
