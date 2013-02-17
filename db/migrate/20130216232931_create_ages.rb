class CreateAges < ActiveRecord::Migration
  def up
    create_table :ages do |t|
      t.string :name
      t.integer :min_age
      t.integer :max_age
    end
  end

  def down
    drop_table :ages
  end
end
