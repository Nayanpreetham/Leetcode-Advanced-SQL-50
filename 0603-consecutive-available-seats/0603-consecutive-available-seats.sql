/* Write your T-SQL query statement below */

select seat_id
from (
      select seat_id, 
          case
              when (seat_id - lag(seat_id) over(order by seat_id) = 1) then 1 else 0
          end as dd,
          case
              when (seat_id - lead(seat_id) over(order by seat_id) = -1) then 1 else 0
          end as ff
      from Cinema
      where free=1) s
where (dd=0 and ff=1) OR (dd=1 and ff=1) or (dd=1 and ff=0)      



--instead of this we can write 
      
SELECT DISTINCT a.seat_id
FROM Cinema a
JOIN Cinema b 
    ON ABS(a.seat_id - b.seat_id) = 1
   AND a.free = 1 
   AND b.free = 1
ORDER BY a.seat_id ASC;
