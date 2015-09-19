class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :address
      t.string :short_address
      t.integer :clicks, default: 0

      t.timestamps null: false
    end
  end
end
