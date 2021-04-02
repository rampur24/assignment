class CreateUserposts < ActiveRecord::Migration[6.0]
  def change
    create_table :userposts do |t|
      t.string :title
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
