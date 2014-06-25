class CreateGooses < ActiveRecord::Migration
  def change
    create_table :gooses do |t|
      t.string :name
      t.integer :height
      t.timestamps
    end
  end
end
