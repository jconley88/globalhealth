class CreateEggTypes < ActiveRecord::Migration
  def change
    create_table :egg_types do |t|
      t.name
      t.timestamps
    end
  end
end
