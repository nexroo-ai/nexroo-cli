# Nexroo CLI

CLI wrapper for ai-rooms-script with Zitadel authentication for Synvex SaaS features.

## Features

- **Zitadel Authentication**: Secure OIDC PKCE flow for CLI authentication
- **Token Management**: Encrypted local storage with 30-day offline grace period
- **SaaS Integration**: Access Synvex backend features when authenticated
- **Workflow Execution**: Run ai-rooms-script workflows with or without authentication

## Installation

### Quick Install (Recommended)

**Linux/macOS:**
```bash
curl -fsSL https://raw.githubusercontent.com/nexroo-ai/nexroo-cli/main/install.sh | bash
```

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/nexroo-ai/nexroo-cli/main/install.ps1 | iex
```

### Manual Install

```bash
pip install nexroo-cli
nexroo install
```

Or install from source:

```bash
git clone https://github.com/nexroo-ai/nexroo-cli.git
cd nexroo-cli
pip install -e .
nexroo install
```

## Quick Start

After installation, authenticate and run your first workflow:

```bash
# Authenticate with Synvex
nexroo login

# Run a workflow
nexroo run workflow.json
```

## Usage

### Authentication Commands

#### Login
```bash
nexroo login
```

Opens browser for Zitadel authentication. Credentials stored encrypted for 30 days.

#### Logout
```bash
nexroo logout
```

Clears saved credentials.

#### Status
```bash
nexroo status
```

Shows authentication status and token expiration.

### Running Workflows

**With authentication** (SaaS features enabled):
```bash
nexroo run workflow.json
```

**With specific entrypoint**:
```bash
nexroo run workflow.json entrypoint-id
```

**Without authentication** (local-only mode):
```bash
nexroo run workflow.json --no-auth
```

### Additional Options

All ai-rooms-script options are supported:

```bash
nexroo run workflow.json [entrypoint] [options]

Options:
  -v, --verbose          Enable verbose logging
  --mock                 Run in mock mode
  --dry-run              Run in dry-run mode
  --mock-config PATH     Path to mock configuration file
  --payload JSON         JSON payload string
  --payload-file PATH    Path to JSON payload file
  --no-auth              Skip authentication check
```

## How It Works

### With Authentication
- Verifies token with Zitadel
- Passes `SYNVEX_AUTH_TOKEN` to ai-rooms-script
- Sets `SYNVEX_SAAS_ENABLED=true`
- Enables backend API features

### Without Authentication
- Runs ai-rooms-script normally
- No SaaS features available
- Fully functional for local workflows

## Authentication Flow

1. **Login**: `nexroo login` opens browser for Zitadel authentication
2. **Token Storage**: Encrypted token stored in `~/.nexroo/auth_token.enc`
3. **Automatic Refresh**: Tokens refresh automatically when online
4. **Grace Period**: 30-day offline usage after token expiration
5. **Re-authentication**: After grace period, re-authenticate with `nexroo login`

## Security

- **Hardcoded Configuration**: Zitadel instance configuration is embedded in the binary (cannot be overridden)
- **Token Encryption**: Tokens stored with Fernet encryption
- **PKCE Flow**: No client secrets required for CLI
- **File Permissions**: Key files stored with 0600 permissions
- **JWT Verification**: All tokens verified against Zitadel's public keys

## Storage Locations

- Encrypted tokens: `~/.nexroo/auth_token.enc`
- Encryption key: `~/.nexroo/.key` (0600 permissions)

## Troubleshooting

### Authentication fails
```bash
nexroo logout
nexroo login
```

### Token expired
```bash
nexroo status  # Check status
nexroo login   # Re-authenticate
```

### ai-rooms-script not found
```bash
pip install ai-rooms-script
```

## Development

Install in development mode:

```bash
git clone https://github.com/nexroo-ai/nexroo-cli.git
cd nexroo-cli
pip install -e .
```

## Documentation

See [SCRIPT_AUTH.md](./SCRIPT_AUTH.md) for detailed authentication architecture.

## License

MIT License - see [LICENSE](./LICENSE) file for details.

## Support

- GitHub Issues: https://github.com/nexroo-ai/nexroo-cli/issues
- Documentation: https://docs.synvex.ai
