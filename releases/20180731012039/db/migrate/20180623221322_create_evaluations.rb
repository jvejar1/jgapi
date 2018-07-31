class CreateEvaluations < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluations do |t|
      t.references :user, foreign_key: true
      t.references :student, foreign_key: true
      t.references :wally, foreign_key: true
      t.references :fonotest, foreign_key: true
      t.references :hnfset, foreign_key: true
      t.timestamp :realized_at
      t.references :ace, foreign_key: true

      t.timestamps
    end
  end
end
