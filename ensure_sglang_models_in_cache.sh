#!/bin/bash
set -e

echo "Ensuring SGLang models are registered in the Hugging Face cache..."

# Define the path to the sglang virtual environment and huggingface-cli
SGLANG_HOME_DIR="$HOME/sglang"
VENV_DIR="$SGLANG_HOME_DIR/sglang_env"
HF_CLI="$VENV_DIR/bin/huggingface-cli"

# List of models that were targeted by the setup_sglang.py script
# These are the models we want to ensure are in the HF cache.
MODELS_TO_PROCESS=(
    "Qwen/Qwen3-32B"
    "Qwen/Qwen3-30B-A3B"
    "Qwen/Qwen3-235B-A22B"
)

# Check if the virtual environment and huggingface-cli exist
if [ ! -f "$HF_CLI" ]; then
    echo "Error: huggingface-cli not found at $HF_CLI."
    echo "Please ensure the sglang virtual environment has been created by running llm/setup_sglang.py."
    exit 1
fi
echo "Found huggingface-cli at $HF_CLI."

# The old local models directory (for user information)
OLD_MODELS_DIR="$SGLANG_HOME_DIR/models"

echo ""
echo "This script will use '$HF_CLI download <model_id>' for each model."
echo "This ensures the models are correctly placed and structured in the Hugging Face cache"
echo "(usually located at ~/.cache/huggingface/hub)."
echo "If models are already cached, they will not be re-downloaded."
echo ""

for model_id in "${MODELS_TO_PROCESS[@]}"; do
    echo "--------------------------------------------------"
    echo "Processing model: $model_id"
    echo "--------------------------------------------------"
    if "$HF_CLI" download "$model_id"; then
        echo "Successfully processed (downloaded/verified cache for) $model_id."
    else
        echo "Warning: There was an issue processing $model_id. Please check the output above."
    fi
    echo ""
done

echo "--------------------------------------------------"
echo "All specified models have been processed."
echo "--------------------------------------------------"
echo ""
echo "You should now be able to run sglang.launch_server using the model ID, for example:"
echo "  python -m sglang.launch_server --model-path Qwen/Qwen3-32B --tensor-parallel-size 4"
echo ""
echo "The original local model downloads were in: $OLD_MODELS_DIR"
echo "If you are sure the models are now correctly managed by the Hugging Face cache and you want to save disk space,"
echo "you can consider manually deleting the $OLD_MODELS_DIR directory."
echo "For example: rm -rf $OLD_MODELS_DIR"
echo "Please be cautious and ensure your models are accessible via their IDs before deleting."
echo ""
echo "Script finished."
