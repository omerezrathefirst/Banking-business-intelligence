-- ==============================================================
-- SQL CHALLENGE: BANKING BUSINESS INTELLIGENCE
-- Schema: banking_practice
-- Instructions: Write the most efficient SQL query for each business request.
-- ==============================================================

-- --------------------------------------------------------------
-- QUESTION 1: Customer Activity Gaps
-- Business Request: 
-- Management wants to identify "inactive" patterns. Find all customers 
-- who had a gap of more than 45 days between any two of their 
-- approved transactions. Show the customer name and the maximum gap they had.
-- --------------------------------------------------------------

with date_group	as	(select account_id,
					   DATE_FORMAT(txn_date,'%y-%m-%d') as date,
					   coalesce(txn_type,'unknown') as tran_type,
					   sum(amount) as total_Reve
					   from transactions
				where status = 'approved' 
			group by account_id,coalesce(txn_type,'unknown'),DATE_FORMAT(txn_date,'%y-%m-%d')),
            
LAG_FUNC AS	(select account_id,
			   date,
			   LAG(date) over(partition by account_id) as prev_tran
			   from date_Group)
               
Select * from lag_func
where sum(datediff(prev_tran,date) > 45) > 2

---------------------------------

WITH Lag_Func AS (
    SELECT 
        account_id,
        txn_date,
        -- מביאים את התאריך הקודם עבור אותו חשבון
        LAG(txn_date) OVER (PARTITION BY account_id ORDER BY txn_date) AS prev_txn_date
    FROM transactions
    WHERE status = 'approved'
)
SELECT 
    account_id,
    -- מחשבים את ההפרש המקסימלי שנמצא
    MAX(DATEDIFF(txn_date, prev_txn_date)) AS max_gap
FROM Lag_Func
GROUP BY account_id
HAVING max_gap > 45;

-- --------------------------------------------------------------
-- QUESTION 2: The "Golden" Monthly Growth
-- Business Request: 
-- For each branch, calculate the total transaction amount for each month.
-- Add a column that shows the percentage (%) growth or decline 
-- compared to the previous month within that same branch.
-- --------------------------------------------------------------

with month_tran as	(select a.branch,
				   sum(t.amount) as total_amount,
				   month(t.txn_date) as month_date
				   from accounts as a 
				   join transactions as t on a.account_id = t.account_id
                   where t.status = 'approved'
                   group by a.branch,month(t.txn_date))
                   
select branch,
	   total_amount,
       month_date,
       round((total_amount - lag(total_amount) over(partition by branch order by month_date))/ nullif(lag(total_amount) over(partition by branch order by month_date),0) * 100 ,2) as prec_change
       from month_tran
       
 -- --------------------------------------------------------------
-- QUESTION 3: Account Balance Snapshot
-- Business Request: 
-- Create a view of all accounts showing their current actual balance.
-- Remember: 'deposit' is (+) while 'withdrawal' and 'card_purchase' are (-).
-- Only include 'approved' transactions in the calculation.
-- ------------------------------------------------------------

CREATE VIEW Actual_balance as
with balance as	(select account_id,
				   txn_type,		
				   sum(case when txn_type = 'deposit' then amount else 0 end) as depo,
				   sum(case when txn_type = 'withdrawal' or txn_type = 'card_purchase' then amount else 0 end) as withdrawal
				   from transactions 
				   group by account_id,txn_type)
		
select account_id,
	   sum(depo - withdrawal) as actual_bala
	from balance
    group by account_id
					
-- --------------------------------------------------------------
-- QUESTION 4: Fraud Detection - Rapid Fire
-- Business Request: 
-- Identify potential fraud: List all customers who performed 
-- more than 2 transactions on the exact same day. 
-- Show the customer name, the date, and the number of transactions.
-- --------------------------------------------------------------

select c.full_name,
	   t.txn_date,
       count(*) as dup_tran 
       from customers as c 
       join accounts as a on c.customer_id = a.customer_id
       join transactions as t on a.account_id = t.account_id
       where c.status = 'active'
       group by c.full_name,t.txn_date
       having count(*) > 1
       
-- --------------------------------------------------------------
-- QUESTION 5: Regional Performance Ranking
-- Business Request: 
-- In each city, who is the customer with the highest total 
-- expenditure (withdrawals + card purchases)? 
-- Return the city, customer name, and the total spent.
-- --------------------------------------------------------------

with card_with as (select c.city,
					   c.full_name,
					   sum(case when t.txn_type = 'withdrawal' then t.amount else 0 end) as withdrawal,
					   sum(case when t.txn_type = 'card_purchase' then t.amount else 0 end) as card_purch
					   from customers as c
					   join accounts as a on c.customer_id = a.customer_id
					   join transactions as t on a.account_id = t.account_id
					   group by c.city,c.full_name)
				
			select city,
				   full_name,
                   withdrawal + card_purch as total_spent
                   from card_with
                   order by total_spent desc
					   
-- --------------------------------------------------------------
-- QUESTION 6: Detailed Branch Efficiency
-- Business Request: 
-- For each branch, find the ratio between 'approved' and 'declined' 
-- transactions. If a branch has zero declined transactions, 
-- ensure the query returns 0 or the total count instead of failing.
-- --------------------------------------------------------------

with branch_effi as (select a.branch,
			sum(case when t.status = 'approved' then 1 else 0 end) as approved,
			sum(case when t.status = 'declined' then 1 else 0 end) as declined
			from accounts as a 
			join transactions as t on a.account_id = t.account_id 
			group by a.branch)
            
	select branch,
		   approved,
           declined,
           count(*)
           from branch_effi
           
-- --------------------------------------------------------------
-- QUESTION 7: KYC Level Revenue Impact
-- Business Request: 
-- What is the average transaction amount for each KYC Level?
-- Round the result to the nearest whole number and display 
-- the level and the average amount.
-- --------------------------------------------------------------

select c.kyc_level,
	   ROUND(avg(t.amount),0) as total_revenue
       from customers as c 
       join accounts as a on c.customer_id = a.customer_id
       join transactions as t on a.account_id = t.account_id
       group by c.kyc_level
       order by c.kyc_level
       
-- --------------------------------------------------------------
-- QUESTION 8: Account Seniority Segments
-- Business Request: 
-- Retrieve all active accounts (where close_account_date IS NULL) 
-- that have been open for a duration of 5 to 10 years OR 
-- have been open for more than 20 years. 
-- Show Account_id, Branch, and the calculated years of seniority.
-- --------------------------------------------------------------

WITH acc_Age as	  (select account_id,
			   branch,
			   ROUND(DATEDIFF(
						COALESCE(close_account_date,current_date()),
								 open_account_date)/
								 365.00,2) as account_age
							from accounts 
							where close_account_date is null)
select account_id,
	   branch,
       account_age
	from acc_Age
    where account_age between 5 AND 10
	OR Account_Age > 20
							