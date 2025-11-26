DELIMITER $$
CREATE PROCEDURE transfer_money(
    IN p_from_account INT,
    IN p_to_account INT,
    IN p_amount DECIMAL(12,2)
)
main_block: BEGIN
    DECLARE v_balance DECIMAL(12,2);
    DECLARE v_transaction_id INT;
    DECLARE v_daily_total DECIMAL(12,2);
    DECLARE v_email VARCHAR(255);

    -- MINIMUM AMOUNT CHECK
    IF p_amount < 50 THEN
        INSERT INTO transaction_logs (
            transaction_id, account_id, attempted_amount, status, reason
        ) VALUES (NULL, p_from_account, p_amount, 'FAILED','MINIMUM LIMIT NOT MET');

        SELECT 'FAILED: Minimum ₹50 required' AS message;
        LEAVE main_block;
    END IF;

    START TRANSACTION;

    -- FETCH BALANCE WITH LOCK
    SELECT balance INTO v_balance
    FROM accounts
    WHERE account_id = p_from_account
    FOR UPDATE;

    -- BALANCE CHECK
    IF v_balance < p_amount THEN
        INSERT INTO transaction_logs (
            transaction_id, account_id, attempted_amount, status, reason
        ) VALUES (NULL, p_from_account, p_amount, 'FAILED','INSUFFICIENT BALANCE');

        ROLLBACK;
        SELECT 'FAILED: Insufficient Balance' AS message;
        LEAVE main_block;
    END IF;

    -- FRAUD DETECTION 1: DAILY LIMIT
    SELECT COALESCE(SUM(amount),0)
    INTO v_daily_total
    FROM transactions
    WHERE from_account = p_from_account
      AND DATE(created_at) = CURDATE();

    IF (v_daily_total + p_amount) > 50000 THEN
        INSERT INTO transaction_logs (
            transaction_id, account_id, attempted_amount, status, reason
        ) VALUES (NULL, p_from_account, p_amount, 'FAILED','DAILY LIMIT REACHED');

        ROLLBACK;
        SELECT 'FAILED: Daily limit exceeded' AS message;
        LEAVE main_block;
    END IF;

    -- FRAUD DETECTION 2: UNUSUAL AMOUNT (Sudden high amount)
    IF p_amount > (v_balance * 0.8) THEN
        INSERT INTO transaction_logs (
            transaction_id, account_id, attempted_amount, status, reason
        ) VALUES (NULL, p_from_account, p_amount, 'FLAGGED','UNUSUAL ACTIVITY');

        ROLLBACK;
        SELECT 'FAILED: Unusual transaction detected' AS message;
        LEAVE main_block;
    END IF;

    -- BEGIN TRANSFER
    UPDATE accounts
    SET balance = balance - p_amount
    WHERE account_id = p_from_account;

    UPDATE accounts
    SET balance = balance + p_amount
    WHERE account_id = p_to_account;

    INSERT INTO transactions (from_account, to_account, amount)
    VALUES (p_from_account, p_to_account, p_amount);

    SET v_transaction_id = LAST_INSERT_ID();

    -- GET EMAIL OF USER
    SELECT email INTO v_email
    FROM users
    WHERE account_id = p_from_account;

    -- SUCCESS LOGGING
    INSERT INTO transaction_logs (
        transaction_id, account_id, attempted_amount, status, reason, email
    ) VALUES (
        v_transaction_id, p_from_account, p_amount, 'SUCCESS', 'TRANSFER COMPLETED', v_email
    );

    COMMIT;

    SELECT 'SUCCESS: Transfer Completed' AS message;
END$$

DELIMITER ;
