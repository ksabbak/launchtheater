class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
    	t.string :name, null: false

   		t.timestamps(null: false)
    end
  end
end
