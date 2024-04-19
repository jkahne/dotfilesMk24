#!/bin/bash

# Check if PR number is provided
if [ -z "$1" ]; then
    echo "Please provide a PR number."
    exit 1
fi

PR_NUMBER=$1

# Function to check PR status
check_pr_status() {
    gh pr checks "$PR_NUMBER" | grep -q "All checks were successful"
}

# Loop until all checks are successful
while true; do
    if check_pr_status; then
        echo "All checks for PR #$PR_NUMBER passed!"
        # Optional: Use a command to play a sound or send a notification
        # For example, on macOS: osascript -e 'display notification "All checks for PR #$PR_NUMBER passed!" with title "PR Checks"'
        break
    else
        echo -n "."
    fi
    sleep 15 # Wait for 15 seconds before checking again
done
