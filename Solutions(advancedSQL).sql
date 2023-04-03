
--CHALLENGE 1
--- STEP 1
select
t.title_id,
t.au_id,
t2.advance * t.royaltyper / 100 as advance,
t2.price * s.qty * t2.royalty / 100 * t.royaltyper / 100 as sales_royalty
FROM titleauthor t 
INNER JOIN titles t2 
ON t.title_id = t2.title_id
INNER JOIN 
sales s ON s.title_id = t2.title_id;

----------------------
-----STEP 2
select DISTINCT 
t.title_id,
t.au_id,
t2.advance * t.royaltyper / 100 as advance,
t2.price * s.qty * t2.royalty / 100 * t.royaltyper / 100 as sales_royalty,
agregacion.agregated_royalty
FROM titleauthor t 
INNER JOIN titles t2 
ON t.title_id = t2.title_id
INNER JOIN sales s 
ON s.title_id = t2.title_id
inner join 
	(select 
	r.title_id,
	t2.au_id,
	sum(r.royalty) as agregated_royalty
	from roysched r
	inner join titleauthor t2
	on t2.title_id = r.title_id
	group by t2.au_id, r.title_id) agregacion
	on agregacion.title_id = s.title_id
	group by agregacion.title_id, agregacion.au_id;

--------------------------

--STEP 3
select DISTINCT 
t.title_id,
t.au_id,
advance_table.advance,
t2.price * s.qty * t2.royalty / 100 * t.royaltyper / 100 as sales_royalty,
agregacion.agregated_royalty,
sum(advance_table.advance)+ sum(agregacion.agregated_royalty) as profits
FROM titleauthor t 
INNER JOIN titles t2 
ON t.title_id = t2.title_id
INNER JOIN 
	(select
	t.title_id,
	t2.advance * t.royaltyper / 100 as advance
	from titleauthor t
	inner join titles t2 
	on t2.title_id = t.title_id)advance_table
on advance_table.title_id = t.title_id 
INNER JOIN sales s 
ON s.title_id = t2.title_id
inner join 
	(select 
	r.title_id,
	t2.au_id,
	sum(r.royalty) as agregated_royalty
	from roysched r
	inner join titleauthor t2
	on t2.title_id = r.title_id
	group by t2.au_id, r.title_id) agregacion
	on agregacion.title_id = s.title_id
	group by agregacion.title_id, agregacion.au_id
order by profits DESC 
limit 3;

--CHALLENGE 2
CREATE TEMPORARY TABLE my_table as
select DISTINCT 
t.title_id,
t.au_id,
advance_table.advance,
t2.price * s.qty * t2.royalty / 100 * t.royaltyper / 100 as sales_royalty,
agregacion.agregated_royalty,
sum(advance_table.advance)+ sum(agregacion.agregated_royalty) as profits
FROM titleauthor t 
INNER JOIN titles t2 
ON t.title_id = t2.title_id
INNER JOIN 
	(select
	t.title_id,
	t2.advance * t.royaltyper / 100 as advance
	from titleauthor t
	inner join titles t2 
	on t2.title_id = t.title_id)advance_table
on advance_table.title_id = t.title_id 
INNER JOIN sales s 
ON s.title_id = t2.title_id
inner join 
	(select 
	r.title_id,
	t2.au_id,
	sum(r.royalty) as agregated_royalty
	from roysched r
	inner join titleauthor t2
	on t2.title_id = r.title_id
	group by t2.au_id, r.title_id) agregacion
	on agregacion.title_id = s.title_id
group by agregacion.title_id, agregacion.au_id
order by profits DESC 
limit 3;

select * from my_table; --verifico que al llamarlo funciona.

--CHALLENGE 3
CREATE TABLE most_profiting_authors as
select DISTINCT 
t.au_id,
sum(advance_table.advance)+ sum(agregacion.agregated_royalty) as profits
FROM titleauthor t 
INNER JOIN titles t2 
ON t.title_id = t2.title_id
INNER JOIN 
	(select
	t.title_id,
	t2.advance * t.royaltyper / 100 as advance
	from titleauthor t
	inner join titles t2 
	on t2.title_id = t.title_id)advance_table
on advance_table.title_id = t.title_id 
INNER JOIN sales s 
ON s.title_id = t2.title_id
inner join 
	(select 
	r.title_id,
	t2.au_id,
	sum(r.royalty) as agregated_royalty
	from roysched r
	inner join titleauthor t2
	on t2.title_id = r.title_id
	group by t2.au_id, r.title_id) agregacion
	on agregacion.title_id = s.title_id
group by agregacion.title_id, agregacion.au_id
order by profits DESC;

----------
select * from most_profiting_authors;



