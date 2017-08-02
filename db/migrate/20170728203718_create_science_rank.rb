class CreateScienceRank < ActiveRecord::Migration
  def change
    create_table :science_ranks do |t|
      t.string :country_name
      t.float :score
    end
  end
end
