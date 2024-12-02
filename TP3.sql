USE zoo;

SELECT * FROM chat WHERE (id = 2);
SELECT * FROM chat 
ORDER BY nom, age ASC

SELECT age FROM chat WHERE (age BETWEEN 11 AND 19)

SELECT nom FROM chat WHERE (nom) LIKE '%sia%';

SELECT nom FROM chat WHERE (nom) LIKE '%a%';

SELECT SUM(age) / COUNT(age)  FROM chat;

SELECT COUNT(id) FROM chat;

SELECT COUNT(id) FROM chat WHERE (yeux = 'marron');

SELECT yeux, COUNT(yeux)  FROM chat GROUP BY(yeux);