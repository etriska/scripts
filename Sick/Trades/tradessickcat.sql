select category, sum(lev_adj)/8
from um_trades_sick
where adj_date >= '01-JUL-98' and adj_date < '01-JUL-99'
group by category;
