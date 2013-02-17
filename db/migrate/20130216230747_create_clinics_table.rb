class CreateClinicsTable < ActiveRecord::Migration
  def up
    create_table :clinics do |t|
      t.integer :clinic_id
      t.string :price
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :practice_director
      t.string :medical_director
      t.string :lab_director
      t.string :zip
      t.string :phone
      t.string :fax
      t.string :email
      t.string :link
      t.integer :quality
      t.timestamps
    end
  end

  def down
    drop_table :clinics
  end
end
