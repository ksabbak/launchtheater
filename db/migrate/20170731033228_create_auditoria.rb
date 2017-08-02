class CreateAuditoria < ActiveRecord::Migration[5.1]
  def change
    create_table :auditoria do |t|
    	t.integer :capacity, null: false

    	t.timestamps(null: false)
    end
  end
end
