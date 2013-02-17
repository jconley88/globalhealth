class ComplicationsServices < ActiveRecord::Migration
  def up
    create_table :complications_services, :id => false do |t|
      t.integer :complication_id, :null => false
      t.integer :service_id, :null => false
    end
  end

  def down
    drop_table :complications_services
  end
end
