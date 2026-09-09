# Flywheel Engine

Grok Build + Web3 + xurl contribution surface for the Sovereign Invariance Suite.

Live: https://flywheel-engine-igors-projects-2dc0c445.vercel.app

Any user can connect an EVM wallet, bind an existing NFT or ERC-20 (ownership verified on-chain, nothing transferred), attest an X identity with `xurl /2/users/me` or Grok Build MCP, declare engine work, and see a contribution-weighted claim preview.

This is a ledger and preview. It is not a sale of securities and not a promise of profit.

## Grok Build + xurl

```toml
[mcp_servers.xapi]
command = "npx"
args = ["-y", "@xdevplatform/xurl", "mcp", "https://api.x.com/mcp"]
enabled = true
startup_timeout_sec = 300
```

```bash
xurl /2/users/me
```

Paste the JSON into the app.

## Score

- 40% engine work
- 25% X public metrics from xurl
- 20% verified ERC-721 ownership
- 15% verified ERC-20 balance

Share = score / max(score, network floor) of the modeled monthly pool.
