class CreateCostOfLivingRank < ActiveRecord::Migration
  def change
    create_table :cost_of_living_ranks do |t|
      t.string :country_name
      t.float :score
    end
  end
end
