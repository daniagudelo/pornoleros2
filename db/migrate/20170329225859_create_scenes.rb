class CreateScenes < ActiveRecord::Migration[5.0]
  def change
    create_table :scenes do |t|
      t.string :title
      t.string :description
      t.timestamps
    end
  end
end
