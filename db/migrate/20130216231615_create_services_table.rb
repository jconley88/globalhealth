class CreateServicesTable < ActiveRecord::Migration
  def up
    create_table :services do |t|
      t.name
    end
  end

  def down
    drop_table :services
  end
end
