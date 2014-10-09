-- Exercitiul 4 --
SELECT max(count(*)) as "Cel mai mult"
FROM rental r
join title t on r.title_id = t.title_id
GROUP BY t.category;

-- ************************************************************************* --

-- Exercitiul 5 --
SELECT count(*), title_id
from title_copy
where status like upper('available')
group by title_id;

-- ************************************************************************* --
-- Exercitiul 6 --
                 
SELECT distinct t.title, t.title, tc.copy_id, tc.status, 
   (
    CASE
      act_ret_date when null then 'rented' 
      else 'available' 
    end
   ) 
   as "Corect"
from title t, title_copy tc, RENTAL r
where t.title_id = r.title_id 
      and 
      tc.copy_id = r.copy_id;
      
      
--- alta varianta
select tc.copy_id, tc.title_id, tc.status, decode(r.act_ret_date,NULL,'RENTED','AVAILABLE')
from title_copy tc, rental r
where tc.title_id = r.title_id
and tc.copy_id = r.copy_id
and r.book_date in (select max(book_date)
from rental r2
where r2.copy_id = r.copy_id
and r2.title_id = r.title_id)
UNION
(select tc.copy_id, tc.title_id,tc.status,'AVAILABLE'
from title_copy tc
MINUS 
select r.copy_id,r.title_id,tc2.status,'AVAILABLE'
from rental r,title_copy tc2
where r.title_id = tc2.title_id
and r.copy_id = tc2.copy_id)
      
-- ************************************************************************* --
-- Exercitiul 7  --


