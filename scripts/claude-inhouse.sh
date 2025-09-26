#!/bin/bash

# Function to launch Claude Code with in-house LLM configuration
jclaude() {
    # Unset unwanted environment variables for this function scope
    GEMINI_API_KEY="" \
    GOOGLE_CLOUD_PROJECT="" \
    OLLAMA_ENDPOINT="" \
    GOOGLE_APPLICATION_CREDENTIALS="" \
    CLAUDE_CODE_USE_VERTEX="" \
    CLOUD_ML_REGION="" \
    GOOGLE_VERTEX_PROJECT="" \
    ANTHROPIC_VERTEX_PROJECT_ID="" \
    ANTHROPIC_BASE_URL="<YOUR_LLM_ENDPOINT>" \
    ANTHROPIC_AUTH_TOKEN="<YOUR_API_KEY" \
    ANTHROPIC_MODEL="<YOUR_MODEL>" \
    ANTHROPIC_SMALL_FAST_MODEL="<YOUR_FAST_MODEL>" \
    claude "${@:2}"
}
