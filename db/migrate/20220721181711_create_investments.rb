class CreateInvestments < ActiveRecord::Migration[6.1]
  def change
    create_table :investments, id: :uuid, default: "gen_random_uuid()" do |table|
      table.string :investor_mail, null: false
      table.decimal :amount, precision: 8, scale: 2, null: false
      table.references :campaign, type: :uuid, null: false, index: true, foreign_key: true
      table.timestamps
    end
  end
end
