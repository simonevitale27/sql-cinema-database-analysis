-- 1- Il nome di tutte le sale di Pisa

SELECT Nome
FROM sale
WHERE Citta = 'Pisa';

-- 2- Il titolo dei film di F. Fellini prodotti dopo il 1960.

SELECT Titolo
FROM film as f
JOIN registi AS r
ON r.CodRegista = f.Regista
WHERE r.Nome = 'Federico Fellini' AND f.AnnoProduzione > 1960;

SELECT Titolo
FROM film as f
JOIN registi AS r
ON r.CodRegista = f.Regista
WHERE r.Nome LIKE '%Fellini' AND f.AnnoProduzione > 1960;

-- 3- Il titolo e la durata dei film drammatici americani o italiani prodotti dopo il 1990

SELECT Titolo
FROM film
WHERE Genere = 'Drammatico' AND 
Nazionalita IN ('Usa', 'Italia') AND 
AnnoProduzione > 1990;

-- 4- Il titolo dei film commedia italiani prodotti dopo il 1990 oppure francesi

SELECT Titolo
FROM film 
WHERE Genere = 'Commedia' AND 
((Nazionalita = 'Italia' AND AnnoProduzione > 1990) OR
Nazionalita = 'Francia');

-- 5- I titoli dei film dello stesso regista di “Shutter Island”

SELECT Titolo
FROM film
WHERE Regista = (SELECT Regista
FROM film
WHERE Titolo = 'Shutter Island') AND 
Titolo != 'Shutter Island';
-- 6- Il titolo ed il genere dei film proiettati il giorno di Natale 2022

SELECT f.Titolo AS Titolo
, f.Genere AS Genere
FROM film AS f
INNER JOIN proiezioni AS p
ON p.idFilm = f.CodFilm
WHERE p.DataProiezione = '2022-12-25';

-- 7- Il titolo ed il genere dei film proiettati a Roma il giorno di Natale 2022

SELECT f.Titolo AS Titolo
, f.Genere AS Genere
FROM film AS f
INNER JOIN proiezioni AS p
ON p.idFilm = f.CodFilm
INNER JOIN sale AS s
ON s.CodSala = p.CodSala
WHERE p.DataProiezione = '2022-12-25' AND s.Citta = 'Roma';

-- 8- I nomi delle sale di Roma in cui il giorno di Natale 2022 è stato proiettato un film con R.Williams

SELECT s.Nome AS NomeSala
FROM sale AS s
INNER JOIN proiezioni AS p
ON p.CodSala = s.CodSala
INNER JOIN film AS f
ON f.CodFilm = p.idFilm
INNER JOIN recita AS rc
ON rc.IdFilm = f.CodFilm
INNER JOIN attori AS a
ON a.CodAttore = rc.CodAttore
WHERE p.DataProiezione = '2022-12-25' AND 
s.Citta = 'Roma' 
AND a.Nome = 'R.Williams';

-- 9- Il titolo dei film in cui recita M. Mastroianni oppure S.Loren

SELECT f.Titolo AS TitoloFilm
FROM film AS f
INNER JOIN recita AS r
ON r.IdFilm = f.CodFilm
INNER JOIN attori AS a
ON a.CodAttore = r.CodAttore
WHERE a.Nome IN ('M. Mastroianni', 'S. Loren');

-- 10- Il titolo dei film in cui recitano M. Mastroianni e S.Loren

SELECT f.Titolo AS TitoloFilm
FROM film AS f
INNER JOIN recita AS r
ON r.IdFilm = f.CodFilm
INNER JOIN attori AS a
ON a.CodAttore = r.CodAttore
WHERE a.Nome = 'M. Mastroianni' AND f.CodFilm IN (
SELECT IdFilm
FROM recita AS rc
JOIN attori AS at
ON at.CodAttore = rc.CodAttore
WHERE at.Nome = 'S. Loren'
);

-- 11- Per ogni film in cui recita un attore Americano, il titolo del film e il nome dell’attore

SELECT f.Titolo AS TitoloFilm
, a.Nome AS NomeAttore
FROM film AS f
INNER JOIN recita AS r
ON r.IdFilm = f.CodFilm
INNER JOIN attori AS a
ON a.CodAttore = r.CodAttore
WHERE a.Nazionalita = 'Usa';

-- 12- Per ogni film che è stato proiettato a Pisa nel gennaio 2022, il titolo del film e il nome della sala.

SELECT f.Titolo AS TitoloFilm
, s.Nome AS NomeSala
FROM film AS f
INNER JOIN proiezioni AS p
ON p.idFilm = f.CodFilm
INNER JOIN sale AS s
ON s.CodSala = p.CodSala
WHERE s.Citta = 'Pisa' AND
p.DataProiezione BETWEEN '2022-01-01' AND '2022-01-31';

-- 13- Il numero di sale di Pisa con più di 60 posti

SELECT COUNT(*) AS NumeroDiSale
FROM sale
WHERE Posti > 60 AND 
Citta = 'Pisa';

-- 14- Il numero totale di posti nelle sale di Pisa

SELECT SUM(Posti) AS TotPosti
FROM sale
WHERE Citta = 'Pisa';

-- 15- Per ogni città, il numero di sale

SELECT Citta
, COUNT(*) AS NumeroDiSale
FROM sale
GROUP BY Citta;

-- 16- Per ogni città, il numero di sale con più di 60 posti

SELECT Citta
, COUNT(*) AS NumeroSale
FROM sale
WHERE Posti > 60
GROUP BY Citta;

-- 17- Per ogni regista, il numero di film diretti dopo il 1990

SELECT r.Nome AS NomeRegista
, COUNT(*) AS NumeroFilm
FROM registi AS r
INNER JOIN film AS f
ON f.Regista = r.CodRegista
WHERE f.AnnoProduzione > 1990
GROUP BY r.Nome;

-- 18- Per ogni regista, l’incasso totale di tutte le proiezioni dei suoi film

SELECT r.Nome AS NomeRegista
, SUM(p.Incasso) AS IncassoTotale
FROM registi AS r
INNER JOIN film AS f
ON f.Regista = r.CodRegista
INNER JOIN proiezioni AS p
ON p.idFilm = f.CodFilm
GROUP BY r.Nome;

-- 19- Per ogni film di Martin Scorsese, il titolo del film, il numero totale di proiezioni a Pisa e l’incasso totale

SELECT f.Titolo AS Titolo
, COUNT(*) AS NumeroProiezioni
, SUM(p.Incasso) AS TotIncasso
FROM registi AS r
INNER JOIN film AS f
ON f.Regista = r.CodRegista
INNER JOIN proiezioni AS p
ON p.idFilm = f.CodFilm
INNER JOIN sale AS s
ON s.CodSala = p.CodSala
WHERE r.Nome = 'Martin Scorsese' AND s.Citta = 'Pisa'
GROUP BY f.Titolo;

-- 20- Per ogni regista e per ogni attore, il numero di film del regista con l’attore

SELECT r.Nome AS NomeRegista
, a.Nome AS NomeAttore
,COUNT(*) AS NumeroFilm
FROM registi AS r
INNER JOIN film AS f
ON f.Regista = r.CodRegista
INNER JOIN recita AS rc
ON rc.IdFilm = f.CodFilm
INNER JOIN attori AS a
ON a.CodAttore = rc.CodAttore
GROUP BY r.Nome, a.Nome;

-- 21 - Il regista ed il titolo dei film in cui recitano più di 3 attori

SELECT r.Nome AS NomeRegista
, f.Titolo AS TitoloFilm
FROM registi AS r
INNER JOIN film AS f
ON f.Regista = r.CodRegista
INNER JOIN recita AS rc
ON rc.IdFilm = f.CodFilm
INNER JOIN attori AS a
ON a.CodAttore = rc.CodAttore
GROUP BY r.Nome, f.Titolo
HAVING COUNT(*) > 3;

-- 22- Per ogni film prodotto dopo il 2000, il codice, il titolo e l’incasso totale di tutte le sue proiezioni

SELECT f.CodFilm AS CodiceFilm
, f.Titolo AS Titolo
, SUM(Incasso) AS IncassoTot
FROM film AS f
INNER JOIN proiezioni AS p
ON p.idFilm = f.CodFilm
WHERE f.AnnoProduzione > 2000
GROUP BY f.CodFilm, f.Titolo;

-- 23 - Il numero di attori dei film in cui appaiono solo attori nati prima del 1970

SELECT COUNT(DISTINCT(a.CodAttore)) AS NumeroAttori
FROM attori AS a
INNER JOIN recita AS r
ON r.CodAttore = a.CodAttore
WHERE r.IdFilm NOT IN (SELECT IdFilm
FROM recita AS rc
INNER JOIN attori AS at
ON at.CodAttore = rc.CodAttore
WHERE at.AnnoNascita >= 1970);

-- 24- Per ogni film drammatico, il titolo e l’incasso totale di tutte le sue proiezioni

SELECT f.Titolo AS Titolo
, SUM(p.Incasso) AS IncassoTot
FROM film AS f
INNER JOIN proiezioni AS p
ON p.idFilm = f.CodFilm
WHERE f.Genere = 'Drammatico'
GROUP BY f.Titolo;

-- 25- Per ogni film drammatico il titolo e l’incasso totale di tutte le sue proiezioni successive al 1/1/2022

SELECT f.Titolo AS Titolo
, SUM(p.Incasso)
FROM film AS f
INNER JOIN proiezioni AS p
ON p.idFilm = f.CodFilm
WHERE f.Genere = 'Drammatico' AND p.DataProiezione > '2022-01-01'
GROUP BY f.Titolo;

-- 26- Per ogni film drammatico che non è mai stato proiettato prima del 1/1/2022 il titolo e l’incasso totale di tutte le sue proiezioni

SELECT f.Titolo AS Titolo
, SUM(p.Incasso) AS IncassoTot
FROM film AS f
INNER JOIN proiezioni AS p
ON p.idFilm = f.CodFilm
WHERE f.Genere = 'Drammatico' AND
f.CodFilm NOT IN (SELECT idFilm
FROM proiezioni
WHERE DataProiezione < '2022-01-01')
GROUP BY f.Titolo;

-- 27- Per ogni sala di Pisa, che nel mese di aprile 2022 ha incassato più di 2000 €, il nome della sala e l’incasso totale (sempre del mese di aprile 2022)

SELECT s.Nome AS NomeSala
, SUM(p.Incasso) AS IncassoTot
FROM sale AS s
INNER JOIN proiezioni AS p
ON p.CodSala = s.CodSala
WHERE s.Citta = 'Pisa' AND 
p.DataProiezione BETWEEN '2022-04-01' AND '2022-04-30'
GROUP BY s.Nome
HAVING SUM(p.Incasso) > 2000;

-- 28- I titoli dei film che non sono mai stati proiettati a Pisa

SELECT CodFilm
, Titolo
FROM film
WHERE CodFilm NOT IN (SELECT p.idFilm
FROM sale AS s
INNER JOIN proiezioni AS p
ON p.CodSala = s.CodSala
WHERE Citta = 'Pisa');

-- 29- I titoli dei film che sono stati proiettati solo a Roma

SELECT CodFilm
, Titolo
FROM film
WHERE CodFilm IN (SELECT p.idFilm
FROM sale AS s
INNER JOIN proiezioni AS p
ON p.CodSala = s.CodSala
WHERE Citta = 'Roma') AND CodFilm NOT IN (SELECT p.idFilm
FROM sale AS s
INNER JOIN proiezioni AS p
ON p.CodSala = s.CodSala
WHERE Citta <> 'Roma');

-- 30- I titoli dei film dei quali non vi è mai stata una proiezione con incasso superiore a 500 €

SELECT CodFilm
, Titolo
FROM film
WHERE CodFilm NOT IN (SELECT idFilm
FROM proiezioni
WHERE Incasso > 500);

-- 31- I titoli dei film le cui proiezioni hanno sempre ottenuto un incasso superiore a 500 €

SELECT CodFilm
, Titolo
FROM film
WHERE CodFilm NOT IN (SELECT idFilm
FROM proiezioni
WHERE Incasso <= 500) AND 
CodFilm IN (SELECT idFilm
FROM proiezioni);

-- 32- Il nome degli attori italiani che non hanno mai recitato in film di Vittorio De Sica

SELECT Nome
FROM attori
WHERE Nazionalita = 'Italia' AND CodAttore NOT IN (
SELECT r.CodAttore
FROM recita AS r
INNER JOIN film AS f
ON f.CodFilm = r.IdFilm
INNER JOIN registi AS rg
ON rg.CodRegista = f.Regista
WHERE rg.Nome = 'Vittorio De Sica');

-- 33- Il titolo dei film di Fellini in cui non recitano attori italiani

SELECT f.Titolo AS TitoloFilm
FROM registi AS rg
INNER JOIN film AS f
ON f.Regista = rg.CodRegista
WHERE rg.Nome = 'Federico Fellini' AND f.CodFilm NOT IN (
SELECT r.IdFilm
FROM recita AS r
INNER JOIN attori AS a 
ON a. CodAttore = r.CodAttore
WHERE a.Nazionalita = 'Italia');

-- 34- Il titolo dei film senza attori

SELECT f.Titolo AS TitoloFilm
FROM film AS f
LEFT JOIN recita AS r
ON r.IdFilm = f.CodFilm
WHERE r.CodAttore IS NULL;

-- 35- Gli attori che prima del 1980 hanno recitato solo nei film di Fellini

SELECT DISTINCT(a.Nome) AS NomeAttore
FROM attori AS a
INNER JOIN recita AS r
ON r.CodAttore = a.CodAttore
INNER JOIN film AS f
ON f.CodFilm = r.IdFilm
WHERE f.AnnoProduzione < 1980 AND r.CodAttore NOT IN (
SELECT r.CodAttore
FROM recita AS r
INNER JOIN film AS f
ON f.CodFilm = r.IdFilm
INNER JOIN registi AS rg
ON rg.CodRegista = f.Regista
WHERE f.AnnoProduzione < 1980 AND rg.Nome <> 'Federico Fellini');

-- 36- Gli attori che hanno recitato in film di Fellini solo prima del 1980

SELECT DISTINCT(a.Nome) AS NomeAttore
FROM attori AS a
INNER JOIN recita AS r
ON r.CodAttore = a.CodAttore
INNER JOIN film AS f
ON f.CodFilm = r.IdFilm
INNER JOIN registi AS rg
ON rg.CodRegista = f.Regista
WHERE f.AnnoProduzione < 1980 AND
rg.Nome = 'Federico Fellini' AND
r.CodAttore NOT IN (
SELECT r.CodAttore
FROM recita AS r
INNER JOIN film AS f
ON f.CodFilm = r.IdFilm
INNER JOIN registi AS rg
ON rg.CodRegista = f.Regista
WHERE f.AnnoProduzione >= 1980 AND rg.Nome = 'Federico Fellini');
