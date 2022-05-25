class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :user
      
      t.string :name
      t.string :email
      t.string :location
      t.string :category
      t.string :work
      t.string :url
      t.date :dob
      t.timestamps
    end
  end
end
