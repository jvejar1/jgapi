class CreateEvaluationMigrations < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluation_migrations do |t|
      t.references :evaluation_from
      t.references :evaluation_to
      t.timestamps
    end

    add_foreign_key :evaluation_migrations, :evaluations, column: :evaluation_from_id, primary_key: :id
    add_foreign_key :evaluation_migrations, :evaluations, column: :evaluation_to_id, primary_key: :id
  end
end
