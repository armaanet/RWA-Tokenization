# Real-World Asset (RWA) Tokenization Platform

A complete, production-ready implementation of a Real-World Asset tokenization system built on Arbitrum Sepolia testnet. This platform enables fractional ownership of real-world assets through ERC-20 tokens with KYC enforcement, redemption mechanisms, and custody reporting.

## 🏗️ Architecture

The system consists of three main components:

1. **Smart Contract Layer** (Solidity) - On-chain tokenization logic
2. **Custodian Service** (Node.js) - Off-chain settlement and event processing
3. **Frontend** (Vanilla JavaScript) - User interface for token holders

## 📋 Features

### Smart Contract (`RWAToken.sol`)
- ✅ ERC-20 compliant token with Permit support (gasless approvals)
- ✅ Access control with roles (ADMIN, MINTER, CUSTODIAN)
- ✅ Pausable contract for emergency stops
- ✅ KYC whitelist enforcement
- ✅ Redemption request and completion flow
- ✅ Custody reporting mechanism
- ✅ Upgradeability-ready initialization pattern

### Backend Service
- ✅ Real-time event listening for `RedeemRequested` events
- ✅ Mock KYC verification
- ✅ Off-chain settlement simulation
- ✅ Automatic redemption completion on-chain
- ✅ Event logging and error handling

### Frontend
- ✅ MetaMask wallet integration
- ✅ Real-time balance and KYC status display
- ✅ Redemption request interface
- ✅ Live event stream (RedeemRequested, Redeemed, CustodyReported)
- ✅ Modern, responsive UI design

## 🚀 Quick Start

### Prerequisites

- Node.js 18+ and npm
- MetaMask browser extension
- Arbitrum Sepolia testnet ETH (for gas fees)
- Hardhat development environment

### Installation

1. **Clone and install dependencies:**
   ```bash
   npm install
   ```

2. **Configure environment variables:**
   ```bash
   cp .env.example .env
   ```
   
   Edit `.env` and set:
   - `PRIVATE_KEY`: Your wallet private key (without 0x prefix)
   - `ARBITRUM_SEPOLIA_RPC_URL`: Arbitrum Sepolia RPC endpoint
   - `CONTRACT_ADDRESS`: (Will be filled after deployment)
   - `ASSET_ID`: Asset identifier (e.g., "GOLD-VLT-01")
   - `DOCS_URI`: Documentation URI (e.g., "ipfs://exampleDocsCID")

3. **Compile contracts:**
   ```bash
   npm run compile
   ```

### Deployment

1. **Deploy to Arbitrum Sepolia:**
   ```bash
   npm run deploy:sepolia
   ```

2. **Update `.env` with the deployed contract address:**
   ```
   CONTRACT_ADDRESS=0x...
   ```

3. **Update frontend configuration:**
   - Edit `frontend/app.js`
   - Update `CONTRACT_ADDRESS` in the `CONFIG` object with your deployed address
   - **Important:** The contract address must be updated or the frontend won't connect!

### Running the System

1. **Start the custodian service:**
   ```bash
   npm run backend
   ```
   
   The service will:
   - Connect to the blockchain
   - Listen for redemption events
   - Process and complete redemptions automatically

2. **Open the frontend:**
   - Option 1: Open `frontend/index.html` directly in a browser (Chrome/Firefox with MetaMask)
   - Option 2: Use a local server:
     ```bash
     cd frontend
     python -m http.server 8080
     # Or use any other HTTP server
     ```
   - Navigate to `http://localhost:8080`

3. **Connect MetaMask:**
   - Ensure MetaMask is connected to Arbitrum Sepolia testnet
   - Click "Connect MetaMask" in the frontend
   - Approve the connection request

## 📖 Usage Guide

### For Administrators

#### Setting KYC Status
```javascript
// Using Hardhat console or frontend
await contract.setKYCStatus(userAddress, true);
```

#### Minting Tokens
```javascript
// Mint tokens to a KYC-verified address
await contract.mint(userAddress, ethers.parseEther("1000"));
```

#### Reporting Custody
```javascript
// Report custody status
await contract.reportCustody("GOLD-VLT-01", "IN_CUSTODY");
```

#### Pausing/Unpausing Contract
```javascript
// Pause contract in emergency
await contract.pause();

// Unpause contract
await contract.unpause();
```

### For Token Holders

#### Requesting Redemption
1. Connect wallet via frontend
2. Ensure KYC status is verified
3. Enter redemption amount and external ID
4. Submit redemption request
5. Wait for custodian to process (automatic via backend service)

#### Viewing Events
- All redemption and custody events are displayed in real-time in the Events Log section

## 🔐 Security Considerations

### Access Control
- **ADMIN_ROLE**: Full control over contract (pause, KYC, roles)
- **MINTER_ROLE**: Can mint tokens to KYC-verified addresses
- **CUSTODIAN_ROLE**: Can complete redemptions and report custody

### KYC Enforcement
- Tokens can only be minted to KYC-verified addresses
- Redemption requests require KYC verification
- Prevents unauthorized token operations

### Pausable Mechanism
- Contract can be paused in emergency situations
- All state-changing functions respect pause status
- Provides circuit breaker functionality

## 🧪 Testing

### Local Testing

1. **Start local Hardhat node:**
   ```bash
   npm run node
   ```

2. **Deploy to local network:**
   ```bash
   npm run deploy:local
   ```

3. **Run tests:**
   ```bash
   npm test
   ```

### Testnet Testing

1. Deploy to Arbitrum Sepolia (see Deployment section)
2. Get testnet ETH from [Arbitrum Sepolia Faucet](https://faucet.quicknode.com/arbitrum/sepolia)
3. Test redemption flow:
   - Set KYC status for test address
   - Mint tokens to test address
   - Request redemption via frontend
   - Verify backend processes and completes redemption

## 📁 Project Structure

```
VeriRWA/
├── contracts/
│   └── RWAToken.sol          # Main token contract
├── scripts/
│   └── deploy.js             # Deployment script
├── backend/
│   └── custodian-service.js  # Custodian event listener service
├── frontend/
│   ├── index.html            # Frontend HTML
│   ├── styles.css            # Frontend styles
│   └── app.js                # Frontend JavaScript
├── docs/
│   └── ALGORITHM.md          # Algorithm explanation
├── deployments/              # Deployment artifacts
├── hardhat.config.js         # Hardhat configuration
├── package.json              # Dependencies
└── README.md                 # This file
```

## 🔄 Redemption Flow

1. **User requests redemption** via frontend
   - Frontend calls `requestRedemption(amount, externalId)`
   - Tokens are transferred to contract
   - `RedeemRequested` event is emitted

2. **Backend service detects event**
   - Event listener catches `RedeemRequested` event
   - Verifies KYC status (mock)
   - Processes off-chain settlement (simulated)

3. **Backend completes redemption**
   - Calls `completeRedemption(requestId)`
   - Tokens are burned
   - `Redeemed` event is emitted

4. **Frontend updates UI**
   - Event listener catches `Redeemed` event
   - Updates user balance
   - Shows confirmation message

## 🌐 Network Configuration

### Arbitrum Sepolia
- **Chain ID**: 421614
- **RPC URL**: `https://sepolia-rollup.arbitrum.io/rpc`
- **Explorer**: `https://sepolia.arbiscan.io`

### Adding to MetaMask
1. Open MetaMask
2. Go to Settings → Networks → Add Network
3. Enter:
   - Network Name: Arbitrum Sepolia
   - RPC URL: `https://sepolia-rollup.arbitrum.io/rpc`
   - Chain ID: 421614
   - Currency Symbol: ETH
   - Block Explorer: `https://sepolia.arbiscan.io`

## 🐛 Troubleshooting

### Contract Deployment Fails
- Ensure you have sufficient ETH for gas fees
- Verify your private key is correct
- Check RPC URL is accessible

### Frontend Can't Connect
- Ensure MetaMask is installed and unlocked
- Verify you're on Arbitrum Sepolia network
- Check contract address is correct in `app.js`

### Backend Service Errors
- Verify contract address in `.env`
- Ensure private key has sufficient ETH
- Check RPC URL is accessible
- Verify contract is deployed and initialized

### Events Not Showing
- Ensure event listeners are started (click "Start Listening")
- Check browser console for errors
- Verify contract address matches deployed contract

## 📚 Additional Documentation

- [Algorithm Explanation](./docs/ALGORITHM.md) - Detailed system architecture and flow
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts) - Security-audited contract libraries
- [Ethers.js Documentation](https://docs.ethers.org) - Ethereum library documentation
- [Hardhat Documentation](https://hardhat.org/docs) - Development environment docs

## 🔮 Future Enhancements

- [ ] Multi-asset support in single contract
- [ ] Fractional redemption with prorated fees
- [ ] Automated reconciliation jobs
- [ ] Oracle integration for real-time asset valuation
- [ ] Proxy pattern for upgradeability
- [ ] Multi-sig custodian operations
- [ ] Advanced analytics dashboard
- [ ] Mobile app support

## ⚠️ Important Notes

1. **This is a testnet deployment** - Do not use with mainnet assets
2. **KYC verification is mocked** - Implement real KYC in production
3. **Settlement is simulated** - Integrate with real settlement systems
4. **Private keys** - Never commit private keys to version control
5. **Security audits** - Conduct thorough security audits before production use

## 📄 License

MIT License - See LICENSE file for details

## 👥 Contributors

Built with precision and care for real-world asset tokenization.

---

**Built for Arbitrum Sepolia Testnet** | **Version 1.0.0**

