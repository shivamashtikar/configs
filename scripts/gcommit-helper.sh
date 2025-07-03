#!/bin/bash

# This script is a helper for the 'git gcommit' alias.

staged_diff=$(git diff --staged --color=never)
if [ -z "$staged_diff" ]; then
    echo "No staged changes to commit." >&2
    exit 1
fi

echo "Generating commit message..."

# Use printf to safely build the prompt
prompt_template="You are an expert at writing git commit messages. Based on the following git diff, generate a commit message that follows the Conventional Commits specification.\n\nThe response must be in the following format:\n<type>(<scope>): <subject>\n<BLANK LINE>\n<body> of the commit message>\n\nThe first line should be a concise subject line of 50 characters or less.\nAfter the subject, there should be a blank line, followed by a more detailed, multi-line body explaining the \"what\" and \"why\" of the changes.\n\nDo not include any other text, comments, or the diff in your response. Only output the raw commit message.\n\nHere is the diff:\n---\n%s"
prompt=$(printf "$prompt_template" "$staged_diff")

commit_msg=$(echo "$prompt" | gemini)

if [ -z "$commit_msg" ]; then
    echo "Commit message generation failed." >&2
    exit 1
fi

echo
echo "Generated Commit Message:"
echo "-------------------------"
echo "$commit_msg"
echo "-------------------------"

while true; do
    read -p "Commit with this message? [y]es, [n]o, [e]dit: " -r yne
    case $yne in
        [Yy]*|"" )
            echo "$commit_msg" | git commit -F -
            break
            ;;
        [Nn]* )
            echo "Commit aborted."
            break
            ;;
        [Ee]* )
            echo "$commit_msg" | git commit -e -F -
            break
            ;;
        * )
            echo "Please answer [y]es, [n]o, or [e]dit."
            ;;
    esac
done
