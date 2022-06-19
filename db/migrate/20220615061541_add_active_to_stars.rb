class AddActiveToStars < ActiveRecord::Migration[6.0]
  def change
    add_column :stars, :active, :boolean, default: false
  end
end
