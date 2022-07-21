class CreateCampaigns < ActiveRecord::Migration[6.1]
  def change
    create_table :campaigns, id: :uuid, default: "gen_random_uuid()" do |table|
      table.string :name, null: false
      table.string :image_url
      table.decimal :target_amount, precision: 8, scale: 2, null: false
      table.decimal :investment_multiple, precision: 8, scale: 2, null: false
      table.decimal :investment_raised, precision: 8, scale: 2, default: 0, null: false
      table.string :currency_code, null: false
      table.string :sector
      table.string :country_code, null: false
      table.timestamps
    end
  end
end
