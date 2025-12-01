syntex - transfor_money(from_account, to_account, amount)
CALL transfer_money(1001, 1005, 50); -- this should pass


CALL transfer_money(1001, 1005, 500000); --- this case should fail as 1001 account don't have this much money and at the same time max transaction limit s 50,000rs. 
