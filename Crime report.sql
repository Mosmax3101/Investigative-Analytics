--TASK 40A --ABUDU HALIMAT OLUWABUKOLA
/* A  crime has taken place and the detective needs your help
The detective gave you the crime scene report, but somehow you lost it,
You vaguely remember the crime was a murder that occured sometimes Jan 15 2018 
and that it took place in SQL City . start by
retrieving the corresponding crime scene report from the police department database */

SELECT * FROM crime_scene_report
WHERE crime_type = 'murder' AND city = 'SQL City' AND date = 20180115

Select * from Person
where address_street_name = 'Northwestern Dr'
order by address_number desc;

Select * from Person
where name like 'Annabel%'
and address_street_name = 'Franklin Ave'

Select * from Interview
Where person_id IN (14887, 16371)