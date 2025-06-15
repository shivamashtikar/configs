#!/usr/bin/env python3

import subprocess
import os
import pathlib
import sys

# --- Configuration ---
VENV_NAME = "sglang_env"
MODELS_SUBDIR = "models"
# --- End Configuration ---

SCRIPT_DIR = pathlib.Path(__file__).resolve().parent # Keep for script context if needed
SGLANG_INSTALL_DIR = pathlib.Path.home() / "sglang" # New base directory in HOME

VENV_PATH = SGLANG_INSTALL_DIR / VENV_NAME
# MODELS_BASE_DIR is no longer needed as models go to HF cache
# MODELS_BASE_DIR = SGLANG_INSTALL_DIR / MODELS_SUBDIR

# Script is intended for Linux
if sys.platform != "linux":
    print("Error: This script is intended for Linux systems only.", file=sys.stderr)
    sys.exit(1)

BIN_SUBDIR = "bin" # Standard for Linux/macOS
VENV_PIP = VENV_PATH / BIN_SUBDIR / "pip"
VENV_PYTHON = VENV_PATH / BIN_SUBDIR / "python"
VENV_HF_CLI = VENV_PATH / BIN_SUBDIR / "huggingface-cli"

MODELS_TO_DOWNLOAD = [
    "Qwen/Qwen3-32B",
    "Qwen/Qwen3-30B-A3B",
    "Qwen/Qwen3-235B-A22B",
]

def run_command(command, cwd=None, check=True, capture_output=False, text=True):
    """Helper function to run a shell command."""
    print(f"Executing: {' '.join(str(c) for c in command)}")
    try:
        process = subprocess.run(
            command,
            cwd=cwd,
            check=check,
            capture_output=capture_output,
            text=text
        )
        if capture_output:
            print(process.stdout)
            if process.stderr:
                print(process.stderr, file=sys.stderr)
        return process
    except subprocess.CalledProcessError as e:
        print(f"Error executing command: {' '.join(str(c) for c in command)}", file=sys.stderr)
        print(f"Return code: {e.returncode}", file=sys.stderr)
        if e.stdout:
            print(f"Stdout: {e.stdout}", file=sys.stderr)
        if e.stderr:
            print(f"Stderr: {e.stderr}", file=sys.stderr)
        if check: # Only exit if check was True and it failed
            sys.exit(1)
    except FileNotFoundError:
        print(f"Error: Command not found: {command[0]}. Please ensure it's installed and in your PATH.", file=sys.stderr)
        if check:
            sys.exit(1)
    return None # Should only be reached if check=False and an error occurred

def main():
    print("SGLang Python Setup Script")
    print("--------------------------------------------------")

    # Ensure the main sglang installation directory exists
    print(f"Ensuring sglang installation directory exists: {SGLANG_INSTALL_DIR}")
    SGLANG_INSTALL_DIR.mkdir(parents=True, exist_ok=True)

    # Models will be downloaded to the default Hugging Face cache,
    # so no need to create a custom models directory here.

    # Create Python virtual environment
    if VENV_PATH.exists() and (VENV_PATH / BIN_SUBDIR / "python").exists():
        print(f"Virtual environment '{VENV_NAME}' already exists at {VENV_PATH}. Skipping creation.")
    else:
        print(f"Creating Python virtual environment: {VENV_NAME} at {VENV_PATH}...")
        run_command([sys.executable, "-m", "venv", VENV_PATH]) # Use sys.executable for python3
        print("Virtual environment created.")

    # Install packages
    print("Installing sglang and huggingface_hub into the virtual environment...")
    packages_to_install = ["sglang[all]", "huggingface_hub[cli]"]
    run_command([str(VENV_PIP), "install"] + packages_to_install)
    print("Packages installed.")

    # System dependencies (libnuma1) - Typically for Linux
    print("\nNote: sglang might require 'libnuma1' on Linux systems.")
    print("If you are on Linux and encounter runtime issues, you might need to install it using:")
    print("  sudo apt-get update && sudo apt-get install -y libnuma1")
    print("This script does not perform system-level package installations.\n")

    # Download Qwen models to Hugging Face cache
    print("Downloading Qwen models (will use Hugging Face cache)...")
    for model_repo_id in MODELS_TO_DOWNLOAD:
        print(f"Attempting to download/ensure {model_repo_id} is cached...")
        # Removed --local-dir, models will go to default HF cache.
        # huggingface-cli download handles checking if already cached.
        run_command([
            str(VENV_HF_CLI), "download", model_repo_id
        ], check=False) # Don't exit if a single model download fails
        # A more robust check would involve trying to load the model or checking cache status via API if available.
        # For now, we assume `huggingface-cli download` handles it or errors out informatively.
        print(f"Download attempt for {model_repo_id} finished.")
    print("Model downloads attempted.")

    print("\n--------------------------------------------------")
    print("Setup Potentially Complete!")
    print("--------------------------------------------------")
    print(f"Python virtual environment '{VENV_NAME}' is set up at: {VENV_PATH}")
    print(f"Models will be downloaded to and loaded from the default Hugging Face cache directory (usually ~/.cache/huggingface/hub).")
    print("")
    print("IMPORTANT:")
    print("To use sglang and the downloaded models:")
    print(f"1. The sglang environment and models are installed in: {SGLANG_INSTALL_DIR}")
    print(f"2. Activate the virtual environment: source {VENV_PATH}/bin/activate")
    # Alternative activation if user is in SGLANG_INSTALL_DIR:
    # print(f"   Alternatively, cd to {SGLANG_INSTALL_DIR} and run: source {VENV_NAME}/bin/activate")
    print("")
    print("Example commands to launch an sglang server (run these in a new terminal AFTER activating the venv):")
    for model_repo_id in MODELS_TO_DOWNLOAD:
        print(f"# For {model_repo_id}:")
        print(f"# python -m sglang.launch_server --model-path {model_repo_id} --tensor-parallel-size 4")
    print("")
    print("Note on model path for Qwen3-235B-A22B vs Qwen3-335B-A22B:")
    print("Your history showed downloading 'Qwen/Qwen3-235B-A22B' but attempting to launch 'Qwen/Qwen3-335B-A22B'.")
    print("This script downloads 'Qwen/Qwen3-235B-A22B'. If 'Qwen/Qwen3-335B-A22B' is a different model, it needs to be downloaded separately.")
    print("")
    print("To deactivate the virtual environment when you are done: deactivate")
    print("")
    print(f"You can run this script using: python3 {pathlib.Path(__file__).name}")
    print(f"(Ensure it's executable if you run it directly: chmod +x {pathlib.Path(__file__).name})")
    print("--------------------------------------------------")

if __name__ == "__main__":
    main()
