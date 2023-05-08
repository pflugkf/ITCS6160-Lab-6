#Question 1
#Find all people who are male and over 18
SELECT * FROM person WHERE gender = 'male' AND age > 18;

#Question 2
#Find the names of people who are female and age 30 or more.
SELECT name FROM person WHERE gender = 'female' AND age >= 30;

#Question 3
#Find the name of males over 20 years old  who eats cheese pizza
SELECT name FROM eats 
WHERE name IN (SELECT name FROM person WHERE gender = 'male' AND age > 20) AND pizza = 'cheese';

#Question 4
#Find all pizzerias that do not serve pizzas that are $9 or more
SELECT DISTINCT pizzeria FROM serves 
WHERE pizzeria NOT IN (SELECT pizzeria FROM serves WHERE price >= 9.00);

#Question 5
#Find all pizzerias that only serve pizzas that are $9 or more
# (which means pizzerias that do not serve any pizza that is less than $9)
SELECT DISTINCT pizzeria FROM serves 
WHERE pizzeria NOT IN (SELECT pizzeria FROM serves WHERE price < 9.00);

#Question 6A
#Find all pizzas eaten by at least one female over the age of 20 that cost more than $9
#Write the query using only join
SELECT serves.pizzeria, eats.pizza, price
FROM person 
INNER JOIN eats ON person.name = eats.name
INNER JOIN serves ON eats.pizza = serves.pizza
WHERE gender = 'female' AND age > 20 AND price > 9;

#Question 6B
#Find all pizzas eaten by at least one female over the age of 20 that cost more than $9
#Write a query using subquery
SELECT * FROM serves 
WHERE price > 9 
AND pizza IN (SELECT pizza FROM eats 
				WHERE name IN (SELECT name FROM person WHERE gender = 'female' AND age > 20));

#Question 7
#Find the names of all people who have eaten at least one pizza served by Dominos
# but are not Dominos frequent customer.
SELECT DISTINCT name FROM eats
JOIN serves ON eats.pizza = serves.pizza
WHERE serves.pizzeria = 'Dominos'
AND name NOT IN (SELECT name FROM frequents WHERE pizzeria = 'Dominos');

#Question 8
#Find all pizzas that are eaten only by people younger than 24
SELECT DISTINCT eats.pizza, pizzeria FROM eats
JOIN serves ON eats.pizza = serves.pizza
WHERE eats.pizza NOT IN (SELECT DISTINCT pizza FROM eats 
							WHERE name IN (SELECT name FROM person WHERE age > 24));
