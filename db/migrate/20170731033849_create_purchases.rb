class CreatePurchases < ActiveRecord::Migration[5.1]
  def change
    create_table :purchases do |t|
    	t.string :purchaser_name, null: false
    	t.string :purchaser_email, null: false
    	t.references :showtime

    	t.timestamps(null: false)
    end
  end
end
