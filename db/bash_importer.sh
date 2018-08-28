backup_directory="$PWD/backups"
declare -a arr=(
"pictures"
"audios"
"communes"
"schools"
"courses"
"acases"
"aces"
"ace_acases"
"acase_correct_feelings"
"fonotests"
"items"
"fonotest_items"
"wallies"
"wsituations"
"situation_sets"
"wfeelings"
"wreactions"
"corsis"
"csquares"
"csequences"
"corsi_csequences"
"hnfsets"
"hnftests"
"hnfset_hnftests"
"hnftest_figures"
"users"
"students"
"evaluations"
"corsi_evaluations"
"acase_answers"
"hnf_answers"
"wsituation_answers"
"item_answers"
"csequence_answers"
)

for i in "${arr[@]}"
do
   echo "COPY $i from '$backup_directory/$i.csv' DELIMITER ',' CSV HEADER;">>queries.sql
   echo "select setval('$i""_id_seq',(select max(id) from $i));">>queries.sql
   # or do whatever with individual element of the array
done

