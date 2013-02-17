class CreateStatNames < ActiveRecord::Migration
  def change
    create_table :stat_names do |t|
      t.string :code
      t.string :name
      t.timestamps
    end
  end
end
