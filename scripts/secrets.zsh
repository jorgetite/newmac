###############################################################################
# SCRIPT: secrets.zsh
# ROLE: Install private keys and secrets from the Vault
#
# DESCRIPTION:
#   Copies secrets (SSH keys, etc.) from a mounted Vault volume to their
#   expected locations and activates the SSH agent.
#
# DEPENDENCIES:
#   - /Volumes/Vault must be mounted before running this component
###############################################################################

VAULT_DIR="/Volumes/Vault"
VAULT_SSH_DIR="$VAULT_DIR/.ssh"
LOCAL_SSH_DIR="$HOME/.ssh"
SSH_KEY="$LOCAL_SSH_DIR/id_ed25519"

install_secrets() {
    info "Installing secrets..."

    # Verify Vault is mounted
    if [[ ! -d "$VAULT_DIR" ]]; then
        fail_soft "Vault is not mounted at $VAULT_DIR — mount it and re-run"
        return 1
    fi

    if [[ ! -d "$VAULT_SSH_DIR" ]]; then
        fail_soft "No .ssh directory found in Vault at $VAULT_SSH_DIR"
        return 1
    fi

    # Copy .ssh from Vault
    if [[ -d "$LOCAL_SSH_DIR" ]]; then
        warn "$LOCAL_SSH_DIR already exists — skipping copy"
        log_msg "skip" "$LOCAL_SSH_DIR already exists"
    else
        if ! run_cmd "Copy .ssh from Vault" "cp -r '$VAULT_SSH_DIR' '$LOCAL_SSH_DIR'"; then
            fail_soft "Failed to copy .ssh from Vault"
            return 1
        fi
    fi

    # Set correct permissions on .ssh directory and key files
    run_cmd "Set .ssh directory permissions" "chmod 700 '$LOCAL_SSH_DIR'"
    run_cmd "Set private key permissions"    "chmod 600 '$LOCAL_SSH_DIR'/id_* 2>/dev/null || true"
    run_cmd "Set public key permissions"     "chmod 644 '$LOCAL_SSH_DIR'/*.pub 2>/dev/null || true"

    # Activate SSH agent and add key to keychain
    if [[ ! -f "$SSH_KEY" ]]; then
        warn "SSH key not found at $SSH_KEY — skipping agent setup"
        log_msg "skip" "SSH key not found: $SSH_KEY"
    else
        run_cmd "Start SSH agent" "eval \"\$(ssh-agent -s)\""
        if ! run_cmd "Add SSH key to keychain" \
            "ssh-add --apple-use-keychain '$SSH_KEY'"; then
            fail_soft "Failed to add SSH key to keychain"
            return 1
        fi
    fi

    ok "Secrets installed"
    return 0
}
