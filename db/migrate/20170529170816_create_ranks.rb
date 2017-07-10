class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.belongs_to :country, index: true
      t.float :score
      t.string :name
      t.string :order

      t.timestamps null: false
    end
  end
end
