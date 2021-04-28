class CreateThings < ActiveRecord::Migration[6.1]
  def change
    create_table :things do |t|
      t.string :name
      t.integer :age
      t.integer :pronoun_id

      t.timestamps
    end
  end
end
