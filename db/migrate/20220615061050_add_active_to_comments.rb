class AddActiveToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :active, :boolean, default: false
  end
end
