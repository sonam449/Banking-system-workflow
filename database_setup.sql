create database bankTrans;
USE bankTrans;
create table if not exists customers
( customer_id int primary key,
  name varchar(50),
  email varchar(150)
);


create table if not exists accounts
( account_id int primary key,
  customer_id int,
  balance DECIMAL(12,2) CHECK (balance >= 0),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)

);

CREATE TABLE KYC_details (
    kyc_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    id_proof_type VARCHAR(50) NOT NULL,
    id_proof_number VARCHAR(100) UNIQUE NOT NULL,
    address_proof_type VARCHAR(50),
    address_proof_number VARCHAR(100),
    verification_status ENUM('PENDING', 'VERIFIED', 'REJECTED') DEFAULT 'PENDING',
    verified_on DATETIME,
    
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    from_account INT NOT NULL,
    to_account INT NOT NULL,
    amount DECIMAL(12,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (from_account) REFERENCES accounts(account_id),
    FOREIGN KEY (to_account) REFERENCES accounts(account_id)
);


CREATE TABLE if not exists transaction_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT,
    account_id INT NOT NULL,
    attempted_amount DECIMAL(12,2),
    status ENUM('SUCCESS', 'FAILED', 'ROLLBACK') NOT NULL,
    reason VARCHAR(255),
    logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    staff_name VARCHAR(100) NOT NULL,
    role ENUM('TELLER', 'MANAGER', 'KYC_OFFICER', 'AUDITOR') NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    branch VARCHAR(100),
    joined_on DATE
);
