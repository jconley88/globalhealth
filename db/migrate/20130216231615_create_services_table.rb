class CreateServicesTable < ActiveRecord::Migration
  def up
    create_table :services do |t|
      t.string :code
      t.string :name
      t.timestamps
    end
  end

  def down
    drop_table :services
  end
end
