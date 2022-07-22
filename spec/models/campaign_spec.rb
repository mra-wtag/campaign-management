require 'spec_helper'

RSpec.describe Campaign, type: :model do
  it { is_expected.to validate_presence_of(:name) } 
  it { is_expected.to validate_presence_of(:target_amount) } 
  it { is_expected.to validate_presence_of(:investment_multiple) } 
  it { is_expected.to validate_presence_of(:investment_raised) } 
  it { is_expected.to validate_presence_of(:country_code) }
  
  it { should have_many :investments }
end
