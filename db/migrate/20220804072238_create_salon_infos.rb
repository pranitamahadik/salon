class CreateSalonInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :salon_infos do |t|
      t.string :company_name
      t.string :gstin
      t.string :pan
      t.text :address
      t.integer :chair_count
      t.integer :day
      t.time :open
      t.time :closes

      t.timestamps
    end
  end
end
