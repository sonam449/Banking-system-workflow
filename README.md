# Banking-system-workflow
Build a simplified digital banking system containing customers, accounts, KYC verification, staff management, transactions, fraud detection, and logging.

# Features
1. Customer onboarding  
2. KYC document management  
3. Account creation and balance tracking  
4. Secure money transfers using stored procedure  
5. Fraud detection rules (daily limit, unusual transactions, min amount)  
6. Complete audit logs  
7. Staff & role system (Teller, Manager, KYC Officer, Auditor)


# Entity Relationships - 
customers        1 ---- *  accounts
accounts         1 ---- *  transactions
accounts         1 ---- *  transaction_logs
customers        1 ---- *  KYC_details
staff            1 ---- *  transaction_logs

# How money transfer procedure works
step 1. Input is given (from_account, to_account, amount)
step 2. Validation & Fraud Checks - Minimum amount ₹50  *AND* Sufficient balance  *AND* Daily transfer limit ₹50,000  *AND* Unusual activity (amount > 80% of balance)
step 3. Transaction Execution- Debit sender account *AND* Credit receiver account *AND* Insert into `transactions` *AND* Insert audit entry into `transaction_logs` 
step 4. Commit or Rollback


Thank you!!

