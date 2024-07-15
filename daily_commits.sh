#!/bin/bash

rand=$(awk -v seed=$RANDOM 'BEGIN { srand(seed); print rand() }')

# 90% probability of commit on a given day
if (( $(echo "$rand <= 0.9" | bc -l) )); then
  echo "Commit for $(date)" >> arbitrary_change.txt
  git add arbitrary_change.txt
  GIT_COMMITTER_DATE="$(date +%Y-%m-%dT%H:%M:%S)" git commit --date="$(date +%Y-%m-%dT%H:%M:%S)" -m "Daily commit for $(date)"
  git push https://x-access-token:${GITHUB_TOKEN}@github.com/sriramjj5/greenify.git
fi
