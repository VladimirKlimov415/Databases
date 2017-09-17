--1:

SELECT name,surname FROM t_workers; --список работников

SELECT name,surname, t_heads.idt_heads
FROM t_workers
INNER JOIN t_heads ON t_workers.idt_workers=t_heads.t_workers_idt_workers; --список начальников отделов

SELECT t_workers.name,t_workers.surname, t_departments.name
FROM t_workers INNER JOIN t_departments
ON t_workers.t_departments_idt_departments=t_departments.idt_departments
WHERE t_departments.name = 'Диспетчеры' --список работников указанного отдела

SELECT name,surname,experience FROM t_workers WHERE experience > 5 --список работников по стажу работников

SELECT name,surname,sex FROM t_workers WHERE sex='М' --список работников по половому признаку

SELECT name,surname,age FROM t_workers WHERE age>30 --список работников по возрасту

SELECT name,surname,children FROM t_workers WHERE children>0 --список работников по наличию детей

SELECT name,surname,salary FROM t_workers WHERE salary>30000 --список работников по заработной плате

--2:
SELECT t_workers.name,t_workers.surname, t_brigades.name
FROM t_workers INNER JOIN t_brigades
ON t_workers.t_brigades_idt_brigades=t_brigades.idt_brigades
WHERE t_brigades.name = 'Бригада 1-1' --список работников в бригаде

SELECT COUNT(t_workers.idt_workers), t_brigades.name
FROM t_workers INNER JOIN t_brigades 
ON t_workers.t_brigades_idt_brigades=t_brigades.idt_brigades 
WHERE t_brigades.name = 'Бригада 1-1' --количество работников в бригаде

SELECT t_workers.name,t_workers.surname, t_locomotives.idt_locomotives
FROM t_workers INNER JOIN t_locomotives
ON t_workers.t_brigades_idt_brigades=t_locomotives.t_brigades_idt_brigades
WHERE t_locomotives.idt_locomotives = 1 --список работников, обслуживающих некоторый локомотив

SELECT t_workers.age, t_brigades.name
FROM t_workers INNER JOIN t_brigades
ON t_workers.t_brigades_idt_brigades=t_brigades.idt_brigades
WHERE t_brigades.name = 'Бригада 1-1' -- список работников в бригаде по возрасту

SELECT AVG(t_workers.salary), t_brigades.name
FROM t_workers INNER JOIN t_brigades
ON t_workers.t_brigades_idt_brigades=t_brigades.idt_brigades
WHERE t_brigades.name = 'Бригада 1-1' --список работников в бригаде по средней зарплате

--3
SELECT t_workers.name,t_workers.surname, t_locomotive_drivers.last_medical_check
FROM t_workers INNER JOIN t_locomotive_drivers
ON t_workers.idt_workers=t_locomotive_drivers.t_workers_idt_workers
WHERE t_locomotive_drivers.last_medical_check>'01.01.2017' --список водителей локомотивов,прошедших медосмотр в указанный год

SELECT COUNT(t_workers.idt_workers)
FROM t_workers INNER JOIN t_locomotive_drivers
ON t_workers.idt_workers=t_locomotive_drivers.t_workers_idt_workers
WHERE t_locomotive_drivers.last_medical_check>'01.01.2017' --количество водителей локомотивов,прошедших медосмотр в указанный год

SELECT t_workers.name,t_workers.surname, t_workers.sex
FROM t_workers INNER JOIN t_locomotive_drivers
ON t_workers.idt_workers=t_locomotive_drivers.t_workers_idt_workers
WHERE t_workers.sex='М' --список водителей локомотивов по половому признаку

SELECT t_workers.name,t_workers.surname, t_workers.age
FROM t_workers INNER JOIN t_locomotive_drivers
ON t_workers.idt_workers=t_locomotive_drivers.t_workers_idt_workers
WHERE t_workers.age >40 --список водителей локомотивов по возрасту

SELECT t_workers.name,t_workers.surname, t_workers.salary
FROM t_workers INNER JOIN t_locomotive_drivers
ON t_workers.idt_workers=t_locomotive_drivers.t_workers_idt_workers
WHERE t_workers.salary >40000 --список водителей локомотивов по заработной плате

--4

SELECT idt_locomotives FROM 't_locomotives' --список локомотивов

SELECT COUNT(idt_locomotives) FROM 't_locomotives' -- количество локомотивов

SELECT idt_locomotives FROM 't_locomotives'
WHERE on_flight=0; --список локомотивов, находящихся на станции в данный момент

SELECT idt_locomotives, num_of_flights FROM `t_locomotives` --список локомотивов, по количеству совершенных маршрутов

--5
SELECT idt_locomotives FROM `t_locomotives`
WHERE `plan_check`>'01.01.2017'  --список локомотивов,прошедших плановый осмотр за определенный период времени

SELECT idt_locomotives FROM t_locomotives
WHERE on_repair=1; --список локомотивов,находящихся в ремонте

SELECT `idt_locomotives` FROM `t_locomotives`
WHERE num_of_repairs=2; --список локомотивов, ремонтированных указанное число раз

SELECT idt_locomotives, num_of_flight_before_repair FROM t_locomotives --список локомотивов по количеству совершенных рейсов до ремонта

SELECT idt_locomotives, age FROM t_locomotives --список локомотивов по возрасту

--6
SELECT t_trains.idt_trains,t_routes.idt_routes FROM t_trains
INNER JOIN t_routes
ON t_routes.idt_routes=t_trains.t_routes_idt_routes
WHERE t_routes.idt_routes=1 --список поездов на маршруте

SELECT COUNT(t_trains.idt_trains) FROM t_trains
INNER JOIN t_routes
ON t_routes.idt_routes=t_trains.t_routes_idt_routes
WHERE t_routes.idt_routes=1 --количество поездов на маршруте

SELECT t_trains.idt_trains,t_routes.time FROM t_trains
INNER JOIN t_routes
ON t_routes.idt_routes=t_trains.t_routes_idt_routes --список поездов по длительности маршрута

SELECT t_trains.idt_trains,t_tickets.ticket_cost FROM t_trains
INNER JOIN t_tickets
ON t_tickets.t_trains_idt_trains=t_trains.idt_trains --список поездов по цене билета

SELECT t_trains.idt_trains,t_tickets.ticket_cost,t_routes.idt_routes 
FROM ((t_trains 
	INNER JOIN t_tickets ON t_tickets.t_trains_idt_trains=t_trains.idt_trains) 
	INNER JOIN t_routes ON t_routes.idt_routes=t_trains.t_routes_idt_routes) --список поездов по нескольким критериям

--7
SELECT t_trains.idt_trains,t_statuses.status_name FROM t_trains
INNER JOIN t_statuses
ON t_statuses.t_trains_idt_trains=t_trains.idt_trains
WHERE t_statuses.status_name='Отменен' --список отменных рейсов

SELECT COUNT(t_trains.idt_trains) FROM t_trains
INNER JOIN t_statuses
ON t_statuses.t_trains_idt_trains=t_trains.idt_trains
WHERE t_statuses.status_name='Отменен' --количество отменных рейсов

SELECT t_trains.idt_trains,t_routes.finish_route,t_statuses.status_name
FROM ((t_trains 
	INNER JOIN t_statuses ON t_statuses.t_trains_idt_trains=t_trains.idt_trains) 
	INNER JOIN t_routes ON t_routes.idt_routes=t_trains.t_routes_idt_routes)
    
    WHERE t_statuses.status_name='Отменен' AND t_routes.finish_route="Сочи" --список отменных рейсов в указанном направлении

SELECT t_trains.idt_trains,t_routes.idt_routes, t_statuses.status_name
FROM ((t_trains 
	INNER JOIN t_statuses ON t_statuses.t_trains_idt_trains=t_trains.idt_trains) 
	INNER JOIN t_routes ON t_routes.idt_routes=t_trains.t_routes_idt_routes)
    
    WHERE t_statuses.status_name='Отменен' AND t_routes.idt_routes=3 --список отменных рейсов по указанному маршруту

--8
SELECT t_trains.idt_trains,t_statuses.status_name FROM t_trains
INNER JOIN t_statuses
ON t_statuses.t_trains_idt_trains=t_trains.idt_trains
WHERE t_statuses.status_name='Задержан' --список задержанных рейсов

SELECT COUNT(t_trains.idt_trains) FROM t_trains
INNER JOIN t_statuses
ON t_statuses.t_trains_idt_trains=t_trains.idt_trains
WHERE t_statuses.status_name='Задержан' --количество задержанных рейсов

SELECT t_trains.idt_trains,t_statuses.status_name, t_statuses.cause FROM t_trains
INNER JOIN t_statuses
ON t_statuses.t_trains_idt_trains=t_trains.idt_trains
WHERE t_statuses.status_name='Задержан' and t_statuses.cause = 'Поломка' --количество задержанных рейсов по указанной причине

SELECT t_trains.idt_trains,t_routes.idt_routes, t_statuses.status_name
FROM ((t_trains 
	INNER JOIN t_statuses ON t_statuses.t_trains_idt_trains=t_trains.idt_trains) 
	INNER JOIN t_routes ON t_routes.idt_routes=t_trains.t_routes_idt_routes)
    
    WHERE t_statuses.status_name='Задержан' AND t_routes.idt_routes=4 --количество задержанных рейсов по указанному маршруту


SELECT t_trains.idt_trains,t_routes.idt_routes, t_statuses.returned_tickets
FROM ((t_trains 
	INNER JOIN t_statuses ON t_statuses.t_trains_idt_trains=t_trains.idt_trains) 
	INNER JOIN t_routes ON t_routes.idt_routes=t_trains.t_routes_idt_routes)
    
    WHERE t_statuses.status_name='Задержан' --количество сданных билетов за время задержки


--9
SELECT t_tickets.idt_tickets ,t_routes.idt_routes
FROM ((t_tickets
	INNER JOIN t_trains ON t_tickets.t_trains_idt_trains=t_trains.idt_trains) 
	INNER JOIN t_routes ON t_routes.idt_routes=t_trains.t_routes_idt_routes)
WHERE t_tickets.date_of_sale>'01.01.2017'  --список проданных билетов по маршруту в указанном интервале

SELECT count(t_tickets.idt_tickets),t_routes.idt_routes
FROM ((t_tickets
	INNER JOIN t_trains ON t_tickets.t_trains_idt_trains=t_trains.idt_trains) 
	INNER JOIN t_routes ON t_routes.idt_routes=t_trains.t_routes_idt_routes) 
   WHERE t_tickets.date_of_sale>'01.01.2017'
 GROUP BY t_routes.idt_routes --количество проданных билетов по маршруту в указанном интервале


SELECT t_tickets.idt_tickets,t_routes.time
FROM ((t_tickets
	INNER JOIN t_trains ON t_tickets.t_trains_idt_trains=t_trains.idt_trains) 
	INNER JOIN t_routes ON t_routes.idt_routes=t_trains.t_routes_idt_routes) --список проданных билетов по длительности

SELECT t_tickets.idt_tickets,t_tickets.ticket_cost FROM t_tickets --список проданных билетов по цене билета

--10
SELECT `idt_routes`,  `finish_route`, `category`
FROM `t_routes`
WHERE finish_route='Москва' and category='Внутренний' --список поездов выбранной категории в указанном направлении

SELECT COUNT(`idt_routes`),  `finish_route`, `category`
FROM `t_routes`
WHERE finish_route='Москва' and category='Внутренний' --количество поездов выбранной категории в указанном направлении

--11
SELECT t_passengers.name, t_passengers.surname, t_tickets.t_trains_idt_trains
FROM t_passengers
INNER JOIN t_tickets
ON t_passengers.t_tickets_idt_tickets=t_tickets.idt_tickets
WHERE t_tickets.t_trains_idt_trains=15 --список пассажиров на указанном рейсе

SELECT count(t_passengers.idt_passengers), t_tickets.t_trains_idt_trains
FROM t_passengers
INNER JOIN t_tickets
ON t_passengers.t_tickets_idt_tickets=t_tickets.idt_tickets
WHERE t_tickets.t_trains_idt_trains=15 --общее число пассажиров на указанном рейсе

SELECT t_passengers.name, t_passengers.surname,t_trains.departure_date
FROM ((t_passengers
INNER JOIN t_tickets ON t_passengers.t_tickets_idt_tickets=t_tickets.idt_tickets)
INNER JOIN t_trains on t_tickets.t_trains_idt_trains=t_trains.idt_trains)
WHERE t_trains.departure_date='2017-08-08' --список пассажиров, уехавших в указанный день

SELECT `name`,`surname`,`baggage` FROM `t_passengers` --список пассажиров по признаку сдачи вещей в багажное отделение

SELECT `name`,`surname`,`sex` FROM `t_passengers` --список пассажиров по половому признаку

SELECT `name`,`surname`,`age` FROM `t_passengers` --список пассажиров по возрасту



--12
SELECT COUNT(idt_tickets) FROM `t_tickets` 
WHERE status='Забронирован' AND `t_trains_idt_trains`=15 --количество невыкупленных билетов на указанный рейс

SELECT COUNT(idt_tickets) FROM `t_tickets` 
WHERE status='Забронирован' AND `date_of_sale`='2017.08.08' --количество невыкупленных билетов в указанный день


SELECT COUNT(t_tickets.idt_tickets) ,t_routes.idt_routes
FROM ((t_tickets
	INNER JOIN t_trains ON t_tickets.t_trains_idt_trains=t_trains.idt_trains) 
	INNER JOIN t_routes ON t_routes.idt_routes=t_trains.t_routes_idt_routes)
    
    WHERE t_tickets.status='Забронирован' and t_routes.idt_routes=3 --количество невыкупленных билетов на указанный маршрут

--13
SELECT COUNT(idt_tickets) FROM `t_tickets` 
WHERE status='Сдан' AND `t_trains_idt_trains`=15 --количество сданных билетов на указанный рейс

SELECT COUNT(idt_tickets) FROM `t_tickets` 
WHERE status='Сдан' AND `date_of_sale`='2017.08.08' --количество сданных билетов в указанный день


SELECT COUNT(t_tickets.idt_tickets) ,t_routes.idt_routes
FROM ((t_tickets
	INNER JOIN t_trains ON t_tickets.t_trains_idt_trains=t_trains.idt_trains) 
	INNER JOIN t_routes ON t_routes.idt_routes=t_trains.t_routes_idt_routes)
    
    WHERE t_tickets.status='Сдан' and t_routes.idt_routes=3 --количество сданных билетов на указанный маршрут


