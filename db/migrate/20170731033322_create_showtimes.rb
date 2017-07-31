class CreateShowtimes < ActiveRecord::Migration[5.1]
  def change
    create_table :showtimes do |t|
    	t.time :start_time, null: false
    	t.time :end_time, null: false
    	t.references :auditorium
    	t.references :movie

    	t.timestamps(null: false)
    end
  end
end
