class CreateClinicsTable < ActiveRecord::Migration
  def up
    create_table :clinics do |t|
      t.string :name
      t.string :address_1
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :email
      t.timestamps
    end
  end

  def down
    drop_table :clinics
  end
end
