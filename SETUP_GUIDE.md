# Setup Guide - Prerequisites

## ⚠️ Required Software

Before proceeding with deployment, you need to install the following:

### 1. Node.js and npm

**Download and install Node.js 18+ from:**
- https://nodejs.org/

**Verify installation:**
```bash
node --version
npm --version
```

### 2. MetaMask Browser Extension

**Install MetaMask:**
- Chrome: https://chrome.google.com/webstore/detail/metamask
- Firefox: https://addons.mozilla.org/en-US/firefox/addon/ether-metamask

### 3. Arbitrum Sepolia Testnet ETH

**Get testnet ETH from:**
- https://faucet.quicknode.com/arbitrum/sepolia
- Or any Arbitrum Sepolia faucet

### 4. Add Arbitrum Sepolia to MetaMask

1. Open MetaMask
2. Go to Settings → Networks → Add Network
3. Enter:
   - **Network Name**: Arbitrum Sepolia
   - **RPC URL**: `https://sepolia-rollup.arbitrum.io/rpc`
   - **Chain ID**: 421614
   - **Currency Symbol**: ETH
   - **Block Explorer**: `https://sepolia.arbiscan.io`

## 📋 Next Steps After Installation

Once Node.js is installed, run:

```bash
# 1. Install dependencies
npm install

# 2. Create .env file
# Copy the template below and create .env file

# 3. Compile contracts
npm run compile

# 4. Deploy to testnet
npm run deploy:sepolia
```

## 🔐 .env File Template

Create a `.env` file in the root directory with:

```env
# Private key of the deployer/admin wallet (without 0x prefix)
PRIVATE_KEY=your_private_key_here

# Arbitrum Sepolia RPC URL
ARBITRUM_SEPOLIA_RPC_URL=https://sepolia-rollup.arbitrum.io/rpc

# Optional: Arbiscan API key for contract verification
ARBISCAN_API_KEY=your_arbiscan_api_key_here

# Contract address (filled after deployment)
CONTRACT_ADDRESS=

# Network name
NETWORK_NAME=Arbitrum Sepolia

# Asset Information
ASSET_ID=GOLD-VLT-01
DOCS_URI=ipfs://exampleDocsCID
```

## ⚠️ Security Warning

**NEVER commit your .env file to version control!**
- Your private key is in this file
- The .gitignore file is already configured to exclude .env

## 🚀 Quick Start Checklist

- [ ] Install Node.js 18+
- [ ] Install MetaMask browser extension
- [ ] Add Arbitrum Sepolia network to MetaMask
- [ ] Get Arbitrum Sepolia testnet ETH
- [ ] Create .env file with your private key
- [ ] Run `npm install`
- [ ] Run `npm run compile`
- [ ] Run `npm run deploy:sepolia`
- [ ] Update contract address in frontend/app.js
- [ ] Start backend service: `npm run backend`
- [ ] Open frontend/index.html in browser

## 📞 Need Help?

Refer to:
- `README.md` - Main documentation
- `docs/DEPLOYMENT.md` - Detailed deployment guide
- `docs/QUICK_START.md` - Quick reference

