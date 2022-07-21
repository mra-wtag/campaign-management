1.upto(500) do |number|
  Campaign.create(name: "Campaign #{number}",
                  image_url: "https://base_url/campaign_#{number}.png",
                  target_amount: (number + 100).to_d * 25,
                  investment_multiple: (number + 2.5).to_d * 2.1,
                  sector: 'common',
                  country_code: 'GB')
end