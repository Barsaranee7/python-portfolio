--Easy module--
--- 1.who is the senior most empoyee based on job title?---
SELECT * FROM employee ORDER BY levels DESC LIMIT 1;
--which country has most invoices?--
SELECT count(*) as c ,billing_country FROM `invoice` group by billing_country order by c desc;
--what are the top 3 values of total invoices?
SELECT * FROM `invoice` order by total desc limit 3;
--wrte a query that returns one city that has hed highest sum of invoice totals. return both the city name and sum of all invoices totals--
   -- Which city has he best customer?--
SELECT billing_city,sum(total) as invoice_total FROM `invoice` group by billing_city order by invoice_total desc;
--wrie a query that returns the person who has spent the money--
-- who is the best customer?--
SELECT c.customer_id,c.first_name,c.last_name, sum(I.total) as invoice_total FROM `customer` as C JOIN invoice as I on c.customer_id=I.customer_id GROUP by c.customer_id ORDER by invoice_total DESC limit 1;

--Moderate--

-- write a query to return the email ,firstname last name & genre of all rock music listener .Return your list order alphabetically by email starting with A--
SELECT DISTINCT C.email,C.first_name,C.last_name from customer as C join invoice as I on C.customer_id=I.customer_id join invoice_line as IL on I.invoice_id=IL.invoice_id where track_;id IN (SELECT track_id from track as T JOIN genre as G on T.track_id=G.genre_id WHERE G.name LIKE 'Rock') order by email;
--Lets invite the artist who have writen he most rock music in our dataset.write a query that returns artist name and total rack count of the op 10 rock bands.--
SELECT Ar.artist_id,Ar.name, COUNT(Ar.artist_id) as number_of_songs from track as T join album as Al on T.album_id=Al.album_id join artist as Ar on Ar.artist_id=Al.artist_id join genre as G on G.genre_id=T.genre_id WHERE G.name LIKE 'Rock' GROUP BY Ar.artist_id ORDER BY number_of_songs DESC LIMIT 10;
--Return all the track names that have a song length longer than the avg song length. Return he name and milliseconds for each track.Order by he song length with the longest song lised first.--
SELECT name,milliseconds from track where milliseconds >(SELECT AVG(milliseconds) as Avg_track_length from track) ORDER by milliseconds DESC;

--Advance--
--find how much amount spent by each cusomer on artists? Write a query to run customer name ,artist name  and total spent--
WITH best_selling_artist AS (
	SELECT artist.artist_id AS artist_id, artist.name AS artist_name, SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 1
)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;
/*- Q2: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */

/* Steps to Solve:  There are two parts in question- first most popular music genre and second need data at country level. */

/* Method 1: Using CTE */
WITH popular_genre AS 
(
    SELECT COUNT(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id, 
	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS RowNo 
    FROM invoice_line 
	JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
	JOIN customer ON customer.customer_id = invoice.customer_id
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN genre ON genre.genre_id = track.genre_id
	GROUP BY 2,3,4
	ORDER BY 2 ASC, 1 DESC
)
SELECT * FROM popular_genre WHERE RowNo <= 1;

/* Q3: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

/* Steps to Solve:  Similar to the above question. There are two parts in question- 
first find the most spent on music for each country and second filter the data for respective customers. */

/* Method 1: using CTE */

WITH Customter_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending,
	    ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo 
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 4 ASC,5 DESC)
SELECT * FROM Customter_with_country WHERE RowNo <= 1;



