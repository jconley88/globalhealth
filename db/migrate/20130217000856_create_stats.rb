class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :clinic_id
      t.integer :age_id
      t.integer :egg_type_id
      t.string :value
      t.timestamps
    end
  end
end
