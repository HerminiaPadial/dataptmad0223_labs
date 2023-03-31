---CHALLENGE 1
SELECT titleauthor.au_id AS AUTHORS_ID,
au_lname AS LAST_NAME,
au_fname AS FIRST_NAME,
title AS TITLE,
pub_name AS PUBLISHER
FROM authors
INNER JOIN titleauthor 
ON authors.au_id = titleauthor.au_id
INNER JOIN titles 
ON titleauthor.title_id = titles.title_id
INNER JOIN publishers p 
ON p.pub_id = titles.pub_id 

---CHALLENGE 2
SELECT titleauthor.au_id AS AUTHORS_ID,
au_fname AS FIRST_NAME,
au_lname AS LAST_NAME,
pub_name AS PUBLISHER,
COUNT(title) AS TITLE_COUNT
FROM authors
INNER JOIN titleauthor
ON authors.au_id = titleauthor.au_id
INNER JOIN titles 
ON titleauthor.title_id = titles.title_id
INNER JOIN publishers p 
ON p.pub_id = titles.pub_id 
GROUP BY titleauthor.au_id, pub_name;

---Creo que el groupby es por estas columnas, aunque me ha creado duda el enunciado.


---CHALLENGE 3

SELECT
a.au_id AS AUTHOR_ID,
a.au_lname AS LAST_NAME,
a.au_fname AS FIRST_NAME,
s.qty AS TOTAL
FROM authors a
LEFT JOIN titleauthor t 
ON a.au_id = t.au_id 
left JOIN sales s 
ON s.title_id =t.title_id
LEFT JOIN titles t2 
ON t2.title_id = t.title_id
GROUP BY 
  a.au_id, 
  a.au_fname, 
  a.au_lname
ORDER BY TOTAL DESC
LIMIT 3;

---- CHALLENGE 4
SELECT
a.au_id AS AUTHOR_ID,
a.au_lname AS LAST_NAME,
a.au_fname AS FIRST_NAME,
NULLIF (COALESCE(SUM(s.qty), 0), 0) AS TOTAL
FROM authors a
LEFT JOIN titleauthor t 
ON a.au_id = t.au_id 
left JOIN sales s 
ON s.title_id =t.title_id
LEFT JOIN titles t2 
ON t2.title_id = t.title_id
GROUP BY 
  a.au_id, 
  a.au_fname, 
  a.au_lname
ORDER BY TOTAL DESC ;
