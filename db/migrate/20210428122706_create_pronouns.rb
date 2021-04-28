class CreatePronouns < ActiveRecord::Migration[6.1]
  def change
    create_table :pronouns do |t|
      t.string :name

      t.timestamps
    end
  end
end
