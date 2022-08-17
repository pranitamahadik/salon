class CreateSalonServices < ActiveRecord::Migration[6.0]
  def change
    create_table :salon_services do |t|
      t.references :salon_info, null: false, foreign_key: true
      t.string :service_type
      t.integer :charges
      t.time :duration

      t.timestamps
    end
  end
end
