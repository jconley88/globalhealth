class CreateEggTypes < ActiveRecord::Migration
  def change
    create_table :egg_types do |t|
      t.string :code
      t.string :name
      t.timestamps
    end
  end
end
