#1. Create a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA. (This has to be done for all 6 stocks)

#creating temp table for converting the date column to date format
create table bajajtemp select str_to_date(Date,'%d-%M-%Y') Date,`Close Price` from `bajaj auto`; 
create table eichertemp select str_to_date(Date,'%d-%M-%Y') Date,`Close Price` from `eicher motors`;
create table herotemp select str_to_date(Date,'%d-%M-%Y') Date,`Close Price` from `hero motocorp`;
create table infosystemp select str_to_date(Date,'%d-%M-%Y') Date,`Close Price` from infosys;
create table tcstemp select str_to_date(Date,'%d-%M-%Y') Date,`Close Price` from tcs;
create table tvstemp select str_to_date(Date,'%d-%M-%Y') Date,`Close Price` from `tvs motors`;

#calculating the 20 day MA and 50 Day MA
# Bajaj
create table bajaj1
select row_number() over w as Day, Date,`Close Price`,
if((ROW_NUMBER() OVER w) > 19, (avg(`Close Price`) OVER (order by Date asc rows 19 PRECEDING)), null) `20 Day MA`,
if((ROW_NUMBER() OVER w) > 49, (avg(`Close Price`) OVER (order by Date asc rows 49 PRECEDING)), null) `50 Day MA`
from bajajtemp
window w as (order by Date asc);
select * from bajaj1 limit 100;

#Eicher 
create table eicher_motors1
select row_number() over w as Day, Date,`Close Price`,
if((ROW_NUMBER() OVER w) > 19, (avg(`Close Price`) OVER (order by Date asc rows 19 PRECEDING)), null) `20 Day MA`,
if((ROW_NUMBER() OVER w) > 49, (avg(`Close Price`) OVER (order by Date asc rows 49 PRECEDING)), null) `50 Day MA`
from eichertemp
window w as (order by Date asc);
select * from eicher_motors1 limit 100;

#Hero motocorp 
create table hero_motocorp1
select row_number() over w as Day, Date,`Close Price`,
if((ROW_NUMBER() OVER w) > 19, (avg(`Close Price`) OVER (order by Date asc rows 19 PRECEDING)), null) `20 Day MA`,
if((ROW_NUMBER() OVER w) > 49, (avg(`Close Price`) OVER (order by Date asc rows 49 PRECEDING)), null) `50 Day MA`
from herotemp
window w as (order by Date asc);
select * from hero_motocorp1 limit 100;

#Infosys
create table infosys1
select row_number() over w as Day, Date,`Close Price`,
if((ROW_NUMBER() OVER w) > 19, (avg(`Close Price`) OVER (order by Date asc rows 19 PRECEDING)), null) `20 Day MA`,
if((ROW_NUMBER() OVER w) > 49, (avg(`Close Price`) OVER (order by Date asc rows 49 PRECEDING)), null) `50 Day MA`
from infosystemp
window w as (order by Date asc);
select * from infosys1 limit 100;

#TCS
create table tcs1
select row_number() over w as Day, Date,`Close Price`,
if((ROW_NUMBER() OVER w) > 19, (avg(`Close Price`) OVER (order by Date asc rows 19 PRECEDING)), null) `20 Day MA`,
if((ROW_NUMBER() OVER w) > 49, (avg(`Close Price`) OVER (order by Date asc rows 49 PRECEDING)), null) `50 Day MA`
from tcstemp
window w as (order by Date asc);
select * from tcs1 limit 100;

#TVS
create table tvs_motors1
select row_number() over w as Day, Date,`Close Price`,
if((ROW_NUMBER() OVER w) > 19, (avg(`Close Price`) OVER (order by Date asc rows 19 PRECEDING)), null) `20 Day MA`,
if((ROW_NUMBER() OVER w) > 49, (avg(`Close Price`) OVER (order by Date asc rows 49 PRECEDING)), null) `50 Day MA`
from tvstemp
window w as (order by Date asc);
select * from tvs_motors1 limit 100;

#Dropping Temporary tables
drop table bajajtemp;
drop table eichertemp;
drop table herotemp;
drop table infosystemp;
drop table tcstemp;
drop table tvstemp;

#creating master table
create table master_table 
select b.Date as Date,b.`Close Price` as Bajaj, e.`Close Price` as Eicher, h.`Close Price` as Hero, i.`Close Price` as Infosys, 
t.`Close Price` as TCS, tv.`Close Price` as TVS
from bajaj1 b
left join eicher_motors1 e on b.Date = e.Date 
left join hero_motocorp1 h on b.Date = h.Date
left join infosys1 i on b.Date = i.Date
left join tcs1 t on b.Date = t.Date
left join tvs_motors1 tv on b.Date = tv.Date;

select * from master_table;

#creating signals for all tables(temp table for all 6 tables)
#for bajaj
create table bajajtemp
select Day, Date, `Close Price`, `20 Day MA`, lag(`20 Day MA`,1) over w as 20_MA_prev, `50 Day MA`, lag(`50 Day MA`,1) over w as 50_MA_prev
from bajaj1
window w as (order by Day);
select * from bajajtemp;

#for eicher
create table eichertemp
select Day, Date, `Close Price`, `20 Day MA`, lag(`20 Day MA`,1) over w as 20_MA_prev, `50 Day MA`, lag(`50 Day MA`,1) over w as 50_MA_prev
from eicher_motors1
window w as (order by Day);
select * from eichertemp;

#for hero
create table herotemp
select Day, Date, `Close Price`, `20 Day MA`, lag(`20 Day MA`,1) over w as 20_MA_prev, `50 Day MA`, lag(`50 Day MA`,1) over w as 50_MA_prev
from hero_motocorp1
window w as (order by Day);
select * from herotemp;

#for infosys
create table infosystemp
select Day, Date, `Close Price`, `20 Day MA`, lag(`20 Day MA`,1) over w as 20_MA_prev, `50 Day MA`, lag(`50 Day MA`,1) over w as 50_MA_prev
from infosys1
window w as (order by Day);
select * from infosystemp;

#for tcs
create table tcstemp
select Day, Date, `Close Price`, `20 Day MA`, lag(`20 Day MA`,1) over w as 20_MA_prev, `50 Day MA`, lag(`50 Day MA`,1) over w as 50_MA_prev
from tcs1
window w as (order by Day);
select * from tcstemp;

#for tvs
create table tvstemp
select Day, Date, `Close Price`, `20 Day MA`, lag(`20 Day MA`,1) over w as 20_MA_prev, `50 Day MA`, lag(`50 Day MA`,1) over w as 50_MA_prev
from tvs_motors1
window w as (order by Day);
select * from tvstemp;

#Creating signal from temp table
#Bajaj 
create table bajaj2
select Date,`Close Price`,
(case when Day > 49 and `20 Day MA` > `50 Day MA` and 20_MA_prev < 50_MA_prev then 'BUY'
	 when Day > 49 and `20 Day MA` < `50 Day MA` and 20_MA_prev > 50_MA_prev then 'SELL'
else 'HOLD' end) as 'Signal'
from bajajtemp;
select * from bajaj2 limit 100;

#Eicher motors 
create table eicher2
select Date,`Close Price`,
(case when Day > 49 and `20 Day MA` > `50 Day MA` and 20_MA_prev < 50_MA_prev then 'BUY'
	 when Day > 49 and `20 Day MA` < `50 Day MA` and 20_MA_prev > 50_MA_prev then 'SELL'
else 'HOLD' end) as 'Signal'
from eichertemp;
select * from eicher2 limit 100;

#For Hero motocorp
create table hero2
select Date,`Close Price`,
(case when Day > 49 and `20 Day MA` > `50 Day MA` and 20_MA_prev < 50_MA_prev then 'BUY'
	 when Day > 49 and `20 Day MA` < `50 Day MA` and 20_MA_prev > 50_MA_prev then 'SELL'
else 'HOLD' end) as 'Signal'
from herotemp;
select * from hero2 limit 100;

#Infosys
create table infosys2
select Date,`Close Price`,
(case when Day > 49 and `20 Day MA` > `50 Day MA` and 20_MA_prev < 50_MA_prev then 'BUY'
	 when Day > 49 and `20 Day MA` < `50 Day MA` and 20_MA_prev > 50_MA_prev then 'SELL'
else 'HOLD' end) as 'Signal'
from infosystemp;
select * from infosys2 limit 100;

#TCS
create table tcs2
select Date,`Close Price`,
(case when Day > 49 and `20 Day MA` > `50 Day MA` and 20_MA_prev < 50_MA_prev then 'BUY'
	 when Day > 49 and `20 Day MA` < `50 Day MA` and 20_MA_prev > 50_MA_prev then 'SELL'
else 'HOLD' end) as 'Signal'
from tcstemp;
select * from tcs2 limit 100;

#TVS
create table tvs2
select Date,`Close Price`,
(case when Day > 49 and `20 Day MA` > `50 Day MA` and 20_MA_prev < 50_MA_prev then 'BUY'
	 when Day > 49 and `20 Day MA` < `50 Day MA` and 20_MA_prev > 50_MA_prev then 'SELL'
else 'HOLD' end) as 'Signal'
from tvstemp;
select * from tvs2 limit 100;

#dropping temp tables
drop table bajajtemp;
drop table eichertemp;
drop table infosystemp;
drop table herotemp;
drop table tcstemp;
drop table tvstemp;

#Create a User defined function, that takes the date as input and returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock.
delimiter $$
create function BSH_signal (s date)
returns char(20) deterministic
begin
declare signal_value varchar(10);
set signal_value = (select `Signal` from bajaj2 where `Date` = s);
return signal_value;
end
$$
delimiter ;

select BSH_signal('2016-01-18') as `signal`;
select BSH_signal('2015-12-08') as `signal`;
select BSH_signal('2015-12-11') as `signal`;
select BSH_signal('2015-12-17') as `signal`;
select BSH_signal('2015-12-22') as `signal`;
select BSH_signal('2015-12-23') as `signal`;