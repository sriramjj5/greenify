#!/bin/bash

rand=$(awk -v seed=$RANDOM 'BEGIN { srand(seed); print rand() }')

echo "Starting script!"

# 90% probability of commit on a given day
if (( $(echo "$rand <= 0.9" | bc -l) )); then
  echo "Creating a commit for $(date)!"
  
  echo "Commit for $(date)" >> arbitrary_change.txt
  git add arbitrary_change.txt
  GIT_COMMITTER_DATE="$(date +%Y-%m-%dT%H:%M:%S)" git commit --date="$(date +%Y-%m-%dT%H:%M:%S)" -m "Daily commit for $(date)"
  echo "Pushing!"
  git push https://sriramjj5:${GH_PAT}@github.com/sriramjj5/greenify.git
else
  echo "No commit created for today!"
fi

echo "End of script!"