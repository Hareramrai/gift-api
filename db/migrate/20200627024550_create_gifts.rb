class CreateGifts < ActiveRecord::Migration[5.2]
  def change
    create_table :gifts do |t|
      t.string :name
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
