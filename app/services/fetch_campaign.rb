class FetchCampaign
  def self.call
    Campaign.all
  end
end