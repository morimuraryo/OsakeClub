class CreateOsakes < ActiveRecord::Migration[6.1]
  def change
    create_table :osakes do |t|
      t.text :title
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end
end
