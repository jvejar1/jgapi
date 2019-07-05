class CreateMoments < ActiveRecord::Migration[5.1]
  def change
    create_table :moments do |t|
      t.date :from
      t.date :until

      t.timestamps
    end
  end
end
