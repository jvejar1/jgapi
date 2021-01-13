class CreateChoices < ActiveRecord::Migration[5.1]
  def change
    create_table :choices do |t|
      t.references :item, foreign_key: true
      t.string :choice_text
      t.integer :choice_value
      t.references :parent_choice, foreign_key: {to_table: :choices}
      t.boolean :is_right
      t.references :picture, foreign_key: true

      t.timestamps
    end
  end
end
