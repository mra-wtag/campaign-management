FactoryBot.define do
  factory :campaign do
    name { 'Campaign 1' }
    image_url { 'https://test_ulr.com/campaign_1.png' }
    target_amount {100.to_d}
    investment_multiple {2.to_d}
    investment_raised {50.to_d}
    country_code {'GB'}
    sector {'Common'}
  end
end
