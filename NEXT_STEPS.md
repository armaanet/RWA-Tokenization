# Next Steps - Deployment Instructions

## 🚨 Prerequisites Check

Before proceeding, ensure you have:

1. **Node.js 18+ installed**
   - Download from: https://nodejs.org/
   - Verify: Run `node --version` in terminal

2. **MetaMask installed**
   - Chrome: https://chrome.google.com/webstore/detail/metamask
   - Firefox: https://addons.mozilla.org/en-US/firefox/addon/ether-metamask

3. **Arbitrum Sepolia testnet ETH**
   - Get from: https://faucet.quicknode.com/arbitrum/sepolia

## 📋 Step-by-Step Deployment

### Step 1: Install Dependencies

```bash
npm install
```

This will install all required packages including Hardhat, ethers.js, and OpenZeppelin contracts.

### Step 2: Create Environment File

```bash
npm run setup:env
```

Or manually create `.env` file from `env.template`:

```bash
# Copy the template
cp env.template .env

# Edit .env and add your private key
# ⚠️ IMPORTANT: Never commit .env to version control!
```

Edit `.env` and add:
- `PRIVATE_KEY`: Your wallet private key (without 0x prefix)
- Other values can use defaults or be customized

### Step 3: Compile Contracts

```bash
npm run compile
```

This will compile the RWAToken contract and create artifacts in the `artifacts/` directory.

### Step 4: Deploy to Arbitrum Sepolia

```bash
npm run deploy:sepolia
```

**Important:** 
- Make sure your wallet has Arbitrum Sepolia ETH for gas fees
- Save the contract address from the deployment output
- The deployment will automatically:
  - Deploy the contract
  - Initialize it with asset metadata
  - Set up roles
  - Unpause the contract

### Step 5: Update Configuration Files

#### Update `.env`:
```env
CONTRACT_ADDRESS=0x...  # Your deployed contract address
```

#### Update `frontend/app.js`:
Open `frontend/app.js` and update:
```javascript
const CONFIG = {
    CONTRACT_ADDRESS: "0x...",  // Your deployed contract address
    // ... rest of config
};
```

### Step 6: Set Up KYC and Mint Tokens

#### Option A: Using Hardhat Console
```bash
npx hardhat console --network arbitrumSepolia
```

Then in the console:
```javascript
const contract = await ethers.getContractAt("RWAToken", "YOUR_CONTRACT_ADDRESS");
const [deployer] = await ethers.getSigners();

// Set KYC status
await contract.setKYCStatus("USER_ADDRESS", true);

// Mint tokens
await contract.mint("USER_ADDRESS", ethers.parseEther("1000"));
```

#### Option B: Using Helper Script
Edit `scripts/helper-operations.js` and uncomment the desired operations, then run:
```bash
npx hardhat run scripts/helper-operations.js --network arbitrumSepolia
```

### Step 7: Start Backend Service

```bash
npm run backend
```

This will:
- Connect to the blockchain
- Listen for `RedeemRequested` events
- Automatically process and complete redemptions

**Keep this terminal running** - the service needs to be active to process redemptions.

### Step 8: Open Frontend

#### Option A: Direct file open
- Open `frontend/index.html` directly in your browser (Chrome/Firefox with MetaMask)

#### Option B: Local server
```bash
# Using Python
cd frontend
python -m http.server 8080

# Or using Node.js
npm run frontend
```

Then navigate to `http://localhost:8080`

### Step 9: Connect and Test

1. **Connect MetaMask:**
   - Ensure MetaMask is connected to Arbitrum Sepolia
   - Click "Connect MetaMask" in the frontend
   - Approve the connection

2. **Verify Connection:**
   - Check that your wallet address is displayed
   - Verify network shows "Arbitrum Sepolia"
   - Check token balance (should show your minted tokens)
   - Verify KYC status (should show "Verified" if you set it)

3. **Test Redemption:**
   - Enter redemption amount (e.g., 50)
   - Enter external ID (e.g., "TEST-001")
   - Click "Request Redemption"
   - Verify transaction is submitted
   - Check backend console for processing logs
   - Verify redemption completes automatically
   - Check events log in frontend

## 🔍 Verification Checklist

- [ ] Node.js 18+ installed
- [ ] Dependencies installed (`npm install`)
- [ ] `.env` file created and configured
- [ ] Contracts compiled (`npm run compile`)
- [ ] Contract deployed to Arbitrum Sepolia
- [ ] Contract address updated in `.env`
- [ ] Contract address updated in `frontend/app.js`
- [ ] KYC status set for test users
- [ ] Test tokens minted
- [ ] Backend service running
- [ ] Frontend accessible
- [ ] MetaMask connected
- [ ] Redemption flow tested end-to-end

## 🐛 Troubleshooting

### "npm is not recognized"
- Install Node.js from https://nodejs.org/
- Restart your terminal after installation

### "Contract deployment failed"
- Check you have Arbitrum Sepolia ETH
- Verify PRIVATE_KEY is correct in `.env`
- Check RPC URL is accessible

### "Frontend can't connect"
- Verify contract address in `app.js`
- Ensure MetaMask is on Arbitrum Sepolia
- Check browser console for errors

### "Backend service errors"
- Verify contract address in `.env`
- Ensure backend wallet has ETH for gas
- Check RPC URL is accessible

### "Events not showing"
- Click "Start Listening" in frontend
- Verify event listeners are active
- Check contract address matches

## 📞 Need Help?

- Check `README.md` for detailed documentation
- See `docs/DEPLOYMENT.md` for deployment guide
- Review `docs/QUICK_START.md` for quick reference
- Check `SETUP_GUIDE.md` for setup instructions

## 🎉 Success!

Once all steps are completed, you should have:
- ✅ Contract deployed on Arbitrum Sepolia
- ✅ Backend service listening for events
- ✅ Frontend connected and functional
- ✅ End-to-end redemption flow working

Congratulations! Your RWA tokenization platform is now running! 🚀

