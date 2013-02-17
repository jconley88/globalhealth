class ClinicsServicesJoinTable < ActiveRecord::Migration
  def up
    create_table :clinics_services, :id => false do |t|
      t.integer :clinic_id, :null => false
      t.integer :service_id, :null => false
    end
  end

  def down
    drop_table :clinics_services
  end
end
