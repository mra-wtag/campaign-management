class FetchCampaign
  def self.call
    Campaign.all.sort_by(&:created_at)
  end
end