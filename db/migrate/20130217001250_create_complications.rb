class CreateComplications < ActiveRecord::Migration
  def change
    create_table :complications do |t|
      t.string :name
      t.timestamps
    end
  end
end
