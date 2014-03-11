class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :merchant, index: true
      t.string :title
      t.text :description
      t.string :url
      t.timestamp :expires_at

      t.timestamps
    end
  end
end
