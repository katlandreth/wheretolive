class CreateFreedomOfPressRank < ActiveRecord::Migration
  def change
    create_table :freedom_of_press_ranks do |t|
      t.string :country_name
      t.float :score
    end
  end
end
