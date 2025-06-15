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
MODELS_BASE_DIR = SGLANG_INSTALL_DIR / MODELS_SUBDIR

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

    # Create the base directory for models within the sglang installation directory
    print(f"Ensuring models directory exists: {MODELS_BASE_DIR}")
    MODELS_BASE_DIR.mkdir(parents=True, exist_ok=True)

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

    # Download Qwen models
    print("Downloading Qwen models...")
    for model_repo_id in MODELS_TO_DOWNLOAD:
        model_short_name = model_repo_id.split('/')[-1]
        target_model_path = MODELS_BASE_DIR / model_short_name

        if target_model_path.exists() and any(target_model_path.iterdir()):
            print(f"Model {model_repo_id} appears to be already downloaded at {target_model_path}. Skipping.")
        else:
            print(f"Downloading {model_repo_id} to {target_model_path}...")
            # Using --local-dir-use-symlinks False to ensure actual files are in target_model_path
            run_command([
                str(VENV_HF_CLI), "download", model_repo_id,
                "--local-dir", str(target_model_path),
                "--local-dir-use-symlinks", "False"
            ], check=False) # Don't exit if a single model download fails
            # We can add a more specific check here if needed, e.g. if the command failed but directory is empty
            if not (target_model_path.exists() and any(target_model_path.iterdir())):
                 print(f"Warning: Download of {model_repo_id} may have failed or resulted in an empty directory.", file=sys.stderr)
            else:
                print(f"{model_repo_id} downloaded (or was already present).")
    print("Model downloads attempted.")

    print("\n--------------------------------------------------")
    print("Setup Potentially Complete!")
    print("--------------------------------------------------")
    print(f"Python virtual environment '{VENV_NAME}' is set up at: {VENV_PATH}")
    print(f"Models are intended to be in: {MODELS_BASE_DIR}")
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
        model_short_name = model_repo_id.split('/')[-1]
        print(f"# For {model_short_name}:")
        print(f"# python -m sglang.launch_server --model-path {MODELS_BASE_DIR / model_short_name} --tensor-parallel-size 4")
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
