#!/bin/bash

# last 2 years

start_date=$(date -d '2 years ago' +%Y-%m-%d)
end_date=$(date +%Y-%m-%d)

while [[ "$start_date" < "$end_date" ]]; do
  rand=$(awk -v seed=$RANDOM 'BEGIN { srand(seed); print rand() }')

  # Only commit if the random number is less than or equal to 0.8 (80%)
  if (( $(echo "$rand <= 0.8" | bc -l) )); then
    echo "Making changes for $start_date"
    echo "Commit for $start_date" >> arbitrary_change.txt
    git add arbitrary_change.txt
    GIT_COMMITTER_DATE="$start_date 12:00:00" git commit --date="$start_date 12:00:00" -m "Backdated commit for $start_date"
  fi

  start_date=$(date -I -d "$start_date + 1 day")
done

git push origin main
