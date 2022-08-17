class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.references :salon_info, null: false, foreign_key: true
      t.references :salon_service, null: false, foreign_key: true
      t.string :user_name
      t.string :mobile
      t.string :gender
      t.time :start_time

      t.timestamps
    end
  end
end
