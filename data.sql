INSERT INTO staff (staff_id, staff_name, role, email, branch, joined_on)
VALUES
(1, 'Amit Verma', 'MANAGER', 'amitverma@123', 'Delhi', '2000-10-15'),
(2, 'Riya Shah', 'KYC_OFFICER', 'riyashah@123', 'Delhi', '2002-09-10'),
(3, 'Karan Mehta', 'TELLER', 'karanmehta@123', 'Mumbai', '2013-01-15'),
(4, 'Sneha Kapoor', 'TELLER', 'snehakapoor@123', 'Pune', '2014-11-15'),
(5, 'Vivek Singh', 'KYC_OFFICER', 'viveksingh@123', 'Pune', '2001-12-15');

create table if not exists customers
( customer_id int primary key,
  name varchar(50),
  email varchar(150),
  city varchar(40),
  phone_no varchar(15)
);
select * from customers;

INSERT INTO customers (customer_id, name, email, city, phone_no)
VALUES
(101, 'Ananya Gupta','ananyagupta@123', 'Delhi', '9988776655'),
(102, 'Rohit Sharma', 'rohitsharma@123', 'Mumbai', '9876543210'),
(103, 'Priya Nair', 'priyanair@123', 'Bangalore','9123456789'),
(104, 'Manish Singh','manishsingh@123', 'Pune', '9900112233'),
(105, 'Sonal Jain','sonaljain@123', 'Delhi', '9811223344'),
(106, 'Arjun Rao', 'arjunrao@123','Hyderabad', '9556677889'),
(107, 'Neha Khosla', 'nehakhosla@123', 'Mumbai', '9322334455'),
(108, 'Harshit Garg', 'harshitagarg@123','Chennai', '9001122334'),
(109, 'Tanya Roy','tanyaroy@123', 'Kolkata', '9988001122'),
(110, 'Kabir Khan', 'kabirkhan@123','Delhi', '9887766554');


INSERT INTO accounts (account_id, customer_id, balance)
VALUES
(1001, 101, 25000),
(1002, 102, 40000),
(1003, 103, 18000),
(1004, 104, 5000),
(1005, 105, 76000),
(1006, 106, 2200),
(1007, 107, 31000),
(1008, 108, 15000),
(1009, 109, 8900),
(1010, 110, 125000);

INSERT INTO KYC_details (customer_id, id_proof_type, id_proof_number, verification_status)
VALUES
(101, 'Aadhar', '1111-2222-3333', 'VERIFIED'),
(102, 'PAN', 'ABCDE1234F', 'VERIFIED'),
(103, 'Aadhar', '4444-5555-6666', 'PENDING'),
(104, 'PAN', 'PQRSX5678L', 'VERIFIED'),
(105, 'Aadhar', '7777-8888-9999', 'REJECTED'),
(106, 'Aadhar', '1234-5678-9999', 'PENDING'),
(107, 'PAN', 'MNOPQ2345K', 'VERIFIED'),
(108, 'Aadhar', '8888-7777-6666', 'VERIFIED'),
(109, 'PAN', 'RSTUV6789Z', 'PENDING'),
(110, 'Aadhar', '1212-3434-5656', 'VERIFIED');
