#!/bin/bash

# Script to test an LLM running on an SGLang server.

# --- Configuration ---
SGLANG_ENDPOINT="http://localhost:30000/v1/chat/completions"
TEMPERATURE=0.6
TOP_P=0.95
TOP_K=20
MAX_TOKENS=2048 # Adjusted to a more common default, can be overridden if needed.

# --- Questions Array ---
# Add more questions here as needed
QUESTIONS=(
    "Give me a short introduction to large language models."
    "What are the key benefits of using Python for data science?"
    "Write a short poem about a curious cat exploring a new city."
    "Explain the concept of a 'for loop' in programming as if you were talking to a 5-year-old."
    "What is the capital of France and what are three famous landmarks there?"
    "Translate 'Hello, how are you?' into Spanish."
    "Summarize the plot of the movie 'Inception' in two sentences."
)

# --- Script Logic ---

MODEL_ID="$1"

if [ -z "$MODEL_ID" ]; then
    echo "No model ID provided. Please select a model to test:"
    DEFAULT_MODELS=(
        "Qwen/Qwen3-30B-A3B"
        "Qwen/Qwen3-235B-A22B"
        "Quit"
    )
    select opt in "${DEFAULT_MODELS[@]}"; do
        case $opt in
            "Qwen/Qwen3-30B-A3B")
                MODEL_ID="Qwen/Qwen3-30B-A3B"
                break
                ;;
            "Qwen/Qwen3-235B-A22B")
                MODEL_ID="Qwen/Qwen3-235B-A22B"
                break
                ;;
            "Quit")
                echo "Exiting."
                exit 0
                ;;
            *) echo "Invalid option $REPLY";;
        esac
    done
    if [ -z "$MODEL_ID" ]; then # Should not happen if Quit is selected, but as a safeguard
        echo "No model selected. Exiting."
        exit 1
    fi
    echo "" # Newline after selection
fi

echo "Testing SGLang server at: $SGLANG_ENDPOINT"
echo "Using Model ID: $MODEL_ID"
echo "Temperature: $TEMPERATURE, Top P: $TOP_P, Top K: $TOP_K, Max Tokens: $MAX_TOKENS"
echo "Number of questions to ask: ${#QUESTIONS[@]}"
echo "--------------------------------------------------"
echo ""

for i in "${!QUESTIONS[@]}"; do
    QUESTION_CONTENT="${QUESTIONS[$i]}"
    
    echo "Question $((i+1)) of ${#QUESTIONS[@]}: $QUESTION_CONTENT"
    echo "---"

    # Construct JSON payload
    # Using heredoc for easier multiline JSON and variable expansion
    JSON_PAYLOAD=$(cat <<EOF
{
  "model": "$MODEL_ID",
  "messages": [
    {"role": "user", "content": "$QUESTION_CONTENT"}
  ],
  "temperature": $TEMPERATURE,
  "top_p": $TOP_P,
  "top_k": $TOP_K,
  "max_tokens": $MAX_TOKENS
}
EOF
)

    echo "Sending request to SGLang server..."
    # echo "Payload: $JSON_PAYLOAD" # Uncomment to debug payload

    # Execute curl command
    # Adding -s for silent mode to suppress progress meter, but show errors
    # If jq is installed, pipe to jq for pretty printing: | jq .
    # Otherwise, print raw JSON.
    if command -v jq &> /dev/null; then
        curl -s -X POST "$SGLANG_ENDPOINT" \
             -H "Content-Type: application/json" \
             -d "$JSON_PAYLOAD" | jq .
    else
        echo "jq not found, printing raw JSON response."
        curl -s -X POST "$SGLANG_ENDPOINT" \
             -H "Content-Type: application/json" \
             -d "$JSON_PAYLOAD"
    fi
    
    echo ""
    echo "--------------------------------------------------"
    echo ""

    # Optional: Add a small delay between requests if needed
    # sleep 1
done

echo "All questions processed."
echo "Script finished."
