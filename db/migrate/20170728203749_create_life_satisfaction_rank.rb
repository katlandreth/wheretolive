class CreateLifeSatisfactionRank < ActiveRecord::Migration
  def change
    create_table :life_satisfaction_ranks do |t|
      t.string :country_name
      t.float :score
    end
  end
end
