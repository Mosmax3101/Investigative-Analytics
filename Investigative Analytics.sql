-- ABUDU HALIMAT OLUWABUKOLA
-- Investigative Analytics Report - This is document that contains the detailed analysis using SQL to find out the murder that took place in the SQL City.

/* A crime has taken place and the detective needs your help. 
The detective gave you the crime scene report, but you somehow lost it. 
You vaguely remember that the crime was a ​murder​ that occurred sometime
on ​Jan.15, 2018​ and that it took place in ​SQL City​. 
Start by retrieving the corresponding crime scene report from 
the police department’s database */ 

--Filter out by using the details provided to find out the
--​Murder​
--​Jan.15, 2018​
--and that it took place in ​SQL City​

SELECT * FROM crime_scene_report
WHERE crime_type = 'murder' AND city = 'SQL City' AND date = 20180115

--After filtering the crime scene report, we came up with the record that reads;
--Security footage shows that there were 2 witnesses. 
--The first witness lives at the last house on "Northwestern Dr". 
--The second witness, named Annabel, lives somewhere on "Franklin Ave".

--FIND WITNESS ONE: Lives at the last house on Northwestern drive

SELECT * FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC;

-- Our First witness has been identified as Morty Schapirro, with ID 14887, 
-- license id 118009, address_4919, street name Northwestern Dr, and SSN 111564949

--Find Witness 2, Annabel who lives somewhere on Franklin ave.

SELECT * FROM Person
WHERE Name LIKE 'Annabel%'
AND address_street_name = 'Franklin Ave'

--Second Witness Is Annabel Miller - ID is 16371, License_id  490173, Address number is 103, 
--Street Franklin Ave, SSN is 318771143

SELECT * FROM interview

----Find the statement of witness 1 and 2

SELECT * FROM Interview
WHERE person_id IN (14887, 16371)

--Witness 1 - I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. 
--The membership number on the bag started with "48Z". Only gold members have those bags. 
--The man got into a car with a plate that included "H42W".

--Witness 2- I saw the murder happen, and I recognized 
--the killer from my gym when I was working out last week on January the 9th.

--Find the "Get Fit Now Gym" bag 
-- Membership number on the bag started with "48Z" For Only Gold Members
--Plate number that includes "H42W"
--January the 9th.

SELECT * FROM get_fit_now_member
WHERE id LIKE '48Z%'
AND membership_status = 'gold'


--From the report from the first witness, We have two suspects with similar gym bag number and membership status
--1. Joe Germuska with id 48Z7A, Person_id 28819, membership_start date 20160305, membership status gold.
--2  Jeremy Bowers with id 48Z55, Person_id 67318, membership_start date 20160101, membership status gold

SELECT * FROM get_fit_now_check_in
WHERE check_in_date = 20180109 AND membership_id IN ('48Z55', '48Z7A')

--Both came to the gym on 9th of January. Next, find the details of the car owner.

--We have to left join at this point.

SELECT * FROM drivers_license

SELECT * FROM person

SELECT dl.age, dl.height, dl.eye_color, dl.gender, dl.plate_number, dl.car_make, dl.car_model, p.name, p.ssn, p.address_number, p.address_street_name,p.id
FROM drivers_license AS DL
LEFT JOIN person AS P
ON dl.id = p.license_id
WHERE plate_number LIKE '%H42W%' OR plate_number LIKE 'H42W%' OR plate_number LIKE '%H42W'


--Congrats, you found the murderer! But wait, there's more... 
--If you think you're up for a challenge, 
--try querying the interview transcript of the murderer to find the real villain behind this crime. 
--If you feel especially confident in your SQL skills, try to complete this final step with no more 
--than 2 queries. Use this same INSERT statement with your new suspect to check your answer.

--Jeremy Bowers ID - 67318

SELECT * FROM interview
WHERE person_id = 67318

--I was hired by a woman with a lot of money. 
--I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
--She has red hair and she drives a Tesla Model S. 
--I know that she attended the SQL Symphony Concert 3 times in December 2017.

CREATE TABLE suspect AS (SELECT * FROM drivers_license
WHERE Height BETWEEN 65 AND 67
AND Hair_color = 'red'
AND gender = 'female'
AND car_make = 'Tesla'
AND car_model = 'Model S')

SELECT * FROM suspect

SELECT * FROM facebook_event_checkin
WHERE event_name = 'SQL Symphony Concert'
AND date BETWEEN  20171201 AND 20171231

--Let us Right Join the person and the suspect table

SELECT s.id, s.age, s.height, p.id AS person_id, p.name, p.address_street_name, p.ssn
FROM suspect AS s
RIGHT JOIN person AS p
ON s.id = p.license_id

---Our threee suspects are Miranda Priestly -ID 99716, Regina Geoge - ID 90700, Red Korb - ID 78881

SELECT * FROM facebook_event_checkin
WHERE event_name = 'SQL Symphony Concert'
AND date BETWEEN  20171201 AND 20171231
AND person_id IN (99716, 90700, 7881)

---99716 = Miranda Priestly
---We've found the person who contracted Jeremy Bowers as Miranda Priestly.
--Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective 
--of all time. Time to break out the champagne!

--This conclude the murder case where we found out the murderer and the mastermind behind the murder.

