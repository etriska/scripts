select lev_code, sum(lev_adj) hrs, sum(lev_adj)/8 days,
(sum(lev_adj)/8) / 400 avg
from um_trades_sick where
adj_date >= '01-JUL-98' and adj_date < '01-JUL-99'
group by lev_code;
select lev_code, sum(lev_adj) hrs, sum(lev_adj)/8 days,
(sum(lev_adj)/8) / 400 avg
from um_trades_sick where
adj_date >= '01-JUL-99' and adj_date < '01-JUL-00'
group by lev_code;
select lev_code, sum(lev_adj) hrs, sum(lev_adj)/8 days,
(sum(lev_adj)/8) / 400 avg
from um_trades_sick where
adj_date >= '01-JUL-00' and adj_date < '01-JUL-01'
group by lev_code;
select lev_code, sum(lev_adj) hrs, sum(lev_adj)/8 days,
(sum(lev_adj)/8) / 400 avg
from um_trades_sick where
adj_date >= '01-JUL-01' and adj_date < '01-JUL-02'
group by lev_code;
select lev_code, sum(lev_adj) hrs, sum(lev_adj)/8 days,
(sum(lev_adj)/8) / 400 avg
from um_trades_sick where
adj_date >= '01-JUL-02' and adj_date < '01-JUL-03'
group by lev_code;
