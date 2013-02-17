class CreateAges < ActiveRecord::Migration
  def up
    create_table :ages do |t|
      t.string :code
      t.string :name
      t.integer :min
      t.integer :max
      t.timestamps
    end
  end

  def down
    drop_table :ages
  end
end
