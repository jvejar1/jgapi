class EvaluationMigration < ApplicationRecord
  belongs_to :evaluation_from
  belongs_to :evaluation_to

  belongs_to :evaluation_from, :class_name => 'Evaluation'
  belongs_to :evaluation_to, :class_name => 'Evaluation'
end
