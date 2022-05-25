class CreateStars < ActiveRecord::Migration[6.0]
  def change
    create_table :stars do |t|
      t.references :post
      t.references :user
      t.integer :star
      t.timestamps
    end
  end
end
