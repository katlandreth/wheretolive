class ChangeCostOfLivingDataType < ActiveRecord::Migration
  def up
   change_column :countries, :cost_of_living_rank, :float
 end

 def down
   change_column :countries, :cost_of_living_rank, :integer
 end
end
