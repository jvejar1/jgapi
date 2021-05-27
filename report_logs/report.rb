n_evals=Evaluation.all.count
n_items=Item.all.count
n_answers=ChoiceAnswer.all.count
n_open_answers=OpenAnswer.all.count
n_corsi_answers=CsequenceAnswer.all.count
n_wally_answers=WsituationAnswer.all.count
n_hnf_answers=HnfAnswer.all.count
n_users = User.all.count

puts "n_evals: #{n_evals} \n n_items: #{n_items} \n n_answers: #{n_answers} \n n_open_answers: #{n_open_answers} \n n_corsi_answers:#{n_corsi_answers} \n n_wally_answers: #{n_wally_answers} \n n_hnf_answers: #{n_hnf_answers} \n n_users: #{n_users}"
