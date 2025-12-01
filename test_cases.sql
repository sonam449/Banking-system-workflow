syntex - transfor_money(from_account, to_account, amount)
CALL transfer_money(1001, 1005, 50); -- this should pass till 3 transactions then fail as the number of transaction limit as reached.


CALL transfer_money(1001, 1005, 500000); --- this case should fail as 1001 account don't have this much money and at the same time max transaction limit s 50,000rs. 


CALL transfer_money(1001, 1005, 5); -- this should fail as well as min transaction amount is 50rs.


CALL transfer_money(1001, 1005, 5000000000); -- this should fail as the amount is too big compared to 1001's account balance.
