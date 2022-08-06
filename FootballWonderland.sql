drop database if exists footballWonderland;
create database footballWonderland;
use footballWonderland;

SET SQL_SAFE_UPDATES = 0;

-- -----------------------------------------------
-- table structures(DO NOT CHANGE!)
-- -----------------------------------------------

DROP TABLE IF EXISTS competition;
CREATE TABLE competition(
  ID char(9) NOT NULL, 
  event char(255) NOT NULL,
  type char(255) NOT NULL,
  year decimal(4, 0) NOT NULL, 
  PRIMARY KEY (ID)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS company;
CREATE TABLE company(
  comp_ID CHAR(9) NOT NULL, 
  comp_name char(255) NOT NULL,
  address char(255) NOT NULL,
  endorse_player char(255),
  PRIMARY KEY (comp_ID)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS team;
CREATE TABLE team(
  ID char(9) NOT NULL, 
  name char(255) NOT NULL,
  country char(255) NOT NULL,
  captain char(255) NOT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS club_team;
CREATE TABLE club_team(
  ID char(9) NOT NULL, 
  country_rank decimal(2, 0) NOT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS national_team;
CREATE TABLE national_team(
  ID char(9) NOT NULL, 
  world_rank decimal(2, 0) NOT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS worker;
CREATE TABLE worker(
  ID CHAR(9) NOT NULL, 
  f_name CHAR(100) NOT NULL,
  l_name CHAR(100) NOT NULL,
  country CHAR(100) NOT NULL,
  entered_year year NOT NULL,
  estimated_salary decimal(3, 0) NOT NULL,
  club char(255) NOT NULL,
  is_coach boolean,
  is_player boolean,
  PRIMARY KEY (ID)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS coach;
CREATE TABLE coach(
  ID CHAR(9) NOT NULL, 
  num_years decimal(3, 0) NOT NULL,
  license char(255) NOT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS player;
CREATE TABLE player(
  ID CHAR(9) NOT NULL, 
  jersey_number decimal(2, 0) NOT NULL,
  position char(255) NOT NULL,
  birthday char(255) NOT NULL,
  num_goals decimal(2, 0) NOT NULL,
  num_assist decimal(2, 0) NOT NULL,
  represent_Nation varchar(255),
  lead_club boolean,
  lead_country boolean,
  PRIMARY KEY (ID)
) ENGINE=InnoDB;


DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
  orderID decimal(4, 0) NOT NULL, 
  num_item_1 decimal(2, 0) NOT NULL,
  price_item_1 decimal(3, 0) NOT NULL,
  name_item_1 Char(100) NOT NULL,
  num_item_2 decimal(2, 0),
  price_item_2 decimal(3, 0),
  name_item_2 Char(100),
  club char(9) NOT NULL,
  selector CHAR(9) NOT NULL,
  PRIMARY KEY (orderID)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS participate;
CREATE TABLE participate(
  teamID char(9) NOT NULL, 
  competition char(9) NOT NULL,
  PRIMARY KEY (teamID,competition)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS sponsor_comp;
CREATE TABLE sponsor_comp(
  company_ID CHAR(9) NOT NULL, 
  competition char(9) NOT NULL,
  PRIMARY KEY (company_ID,competition)
) ENGINE=InnoDB;

-- -----------------------------------------------
-- referential structures(DO NOT CHANGE!)
-- -----------------------------------------------

alter table club_team add constraint fk_1 foreign key (ID) references team (ID)
	on update cascade on delete cascade;

alter table national_team add constraint fk_2 foreign key (ID) references team (ID)
	on update cascade on delete cascade;

alter table coach add constraint coach_fk_3 foreign key (ID) references worker (ID)
	on update cascade on delete cascade;

alter table player add constraint player_fk_4 foreign key (ID) references worker (ID)
	on update cascade on delete cascade;
    
alter table orders add foreign key (club) references club_team(ID)
	on update cascade on delete cascade;
    
alter table participate add constraint fk_6 foreign key (teamID) references team(ID)
	on update cascade on delete cascade;

alter table participate add constraint fk_7 foreign key (competition) references competition(ID)
	on update cascade on delete cascade;

alter table sponsor_comp add constraint fk_8 foreign key (company_ID) references company(comp_ID)
	on update cascade on delete cascade;

alter table sponsor_comp add constraint fk_9 foreign key (competition) references competition(ID)
	on update cascade on delete cascade;


-- -----------------------------------------------
-- table data(DO NOT CHANGE!)
-- -----------------------------------------------
INSERT INTO team VALUES ('RMD', "Real Madrid CF", 'Spain', 'Karim Benzema');
INSERT INTO team VALUES ('MCF', "Manchester City F.C.", 'United Kingdom', 'Fernando Luiz Roza');
INSERT INTO team VALUES ('BEL', 'Belgium national football team',	'Belgium', 'Eden Hazard');
INSERT INTO team VALUES ('CRO', 'Croatia National Football Team',  'Croatia',	'Luka Modric');

INSERT INTO club_team VALUES ('RMD', 1);
INSERT INTO club_team VALUES ('MCF', 1);

INSERT INTO national_team VALUES ('BEL', 2);
INSERT INTO national_team VALUES ('CRO', 15);

INSERT INTO competition VALUES ('wc_18', 'World Cup', 'National game', 2018);
INSERT INTO competition VALUES ('ec_21', 'UEFA European Championship ', 'Club game', 2021);

INSERT INTO worker VALUES ('LM360', 'Luka', 'Modric', 'Croatia', 2012, 325, 'RMD', False, True);
INSERT INTO worker VALUES ('TC361', 'Thibaut', 'Courtois', 'Belgium', 2018, 300, 'RMD', False, True);
INSERT INTO worker VALUES ('KB367', 'Karim', 'Benzema', 'France', 2009, 276, 'RMD', False, True);
INSERT INTO worker VALUES ('EH370', 'Eden', 'Hazard', 'Belgium', 2019, 430, 'RMD', False, True);
INSERT INTO worker VALUES ('CA130', 'Carlo', 'Ancelotti', 'Italy', 2021, 355, 'RMD', True, False);
INSERT INTO worker VALUES ('KD415', 'Kevin', 'De Bruyne', 'Belgium', 2015, 390, 'MCF', False, True);
INSERT INTO worker VALUES ('AP407', 'Ante', 'Palaversa', 'Croatia', 2019, 18, 'MCF', False, True);
INSERT INTO worker VALUES ('PG140', 'Pep', 'Guardiola', 'Spain', 2016, 385, 'MCF', True, False);

INSERT INTO company VALUES ('NK02', 'Nike', 'One Bowerman Dr, Beaverton, OR 97005, United States', 'TC361');
INSERT INTO company VALUES ('CC03', 'Coca-Cola', '1 Coca Cola Plz NW, Atlanta, GA 30313, United States', 'EH370');

INSERT INTO coach VALUES ('PG140', 6, '303-549-882');
INSERT INTO coach VALUES ('CA130', 1, '303-600-411');

INSERT INTO player VALUES ('LM360', 10, 'Midfielder', '09/09/1985', 2, 12, 'Croatia', False, True);
INSERT INTO player VALUES ('TC361', 1, 'Goal-keeper', '05/11/1992', 0, 0, 'Belgium', False, False);
INSERT INTO player VALUES ('KB367', 9, 'Forward', '05/11/1992', 27, 12, 'France', True, False);
INSERT INTO player VALUES ('KD415', 17, 'Midfielder', '06/28/1991', 15, 8, 'Belgium', False, False);
INSERT INTO player VALUES ('EH370', 7, 'Forward', '01/07/1991', 2, 1, 'Belgium', False, True);
INSERT INTO player VALUES ('AP407', 8, 'Midfielder', '04/06/2000', 2, 4, Null, False, False);

INSERT INTO sponsor_comp VALUES ('NK02', 'wc_18');
INSERT INTO sponsor_comp VALUES ('NK02', 'ec_21');
INSERT INTO sponsor_comp VALUES ('CC03', 'wc_18');

INSERT INTO participate VALUES ('RMD', 'ec_21');
INSERT INTO participate VALUES ('MCF', 'ec_21');
INSERT INTO participate VALUES ('BEL', 'wc_18');
INSERT INTO participate VALUES ('CRO', 'wc_18');

INSERT INTO orders VALUES (2316, 30, 100, 'Football', 25, 230, 'Shoes', 'RMD', 'CA130');
INSERT INTO orders VALUES (4400, 2, 300, 'Training poles', Null, Null, Null, 'RMD', 'CA130');


-- -----------------------------------------------
-- stored procedures and views
-- -----------------------------------------------

add_player
delimiter // 
create procedure add_player (in ip_ID char(9),
	in ip_first_name char(100), in ip_last_name char(100),
	in ip_country char(255), in ip_ent_year year,
	in ip_salary decimal(3, 0), in ip_club char(255), in ip_jersey_number decimal(2, 0),
    in ip_position char(255), in ip_birthday char(255), in ip_represent_Nation varchar(255),
    in ip_lead_club boolean, in ip_lead_country boolean)
sp_main: begin
    if not exists (select jersey_number from player where player.ID in (select ID from worker where worker.club = ip_club) and jersey_number = ip_jersey_number) then
		insert into worker values (ip_ID, ip_first_name, ip_last_name, ip_country, ip_ent_year, ip_salary, ip_club, false, true);
		insert into player values (ip_ID, ip_jersey_number, ip_position, ip_birthday, 0, 0, ip_represent_Nation, ip_lead_club, ip_lead_country);
	else
		signal sqlstate '45000' set message_text = 'This jersey number is already being used by other member in the club.';
    end if;
end//
delimiter ;

remove_player
delimiter // 
create procedure remove_player (in ip_ID char(9))
sp_main: begin
	-- removes if exists in system
	if exists (select ID from worker where ID = ip_ID) then
		delete from worker where ip_ID = ID;
	else
		signal sqlstate '45000' set message_text = 'There is no such player in the system.';
	end if;
end //
delimiter ;

add_team
delimiter // 
create procedure add_team (in ip_ID char(9),
	in ip_name char(255),
	in ip_country char(255), in ip_captain char(255),
	in ip_world_rank decimal(2, 0), in ip_country_rank decimal(2.0))
sp_main: begin
	-- automatically throws exception if Team ID is not unique // Duplicate key
    if ip_captain is null then
		signal sqlstate '45000' set message_text = 'Captain must be present.';
	end if;
    
	insert into team values (ip_ID, ip_name, ip_country, ip_captain);
    
    -- Assumes either rank is null, and update the team type table accordingly
    if ip_world_rank is not null then
		insert into national_team values (ip_ID, ip_world_rank);
	end if;
    if ip_country_rank is not null then
		insert into club_team values (ip_ID, ip_country_rank);
	end if;
end //
delimiter ;

-- Supplementary method #1
remove_team
delimiter // 
create procedure remove_team (in ip_ID char(9))
sp_main: begin
	if exists (select ID from team where ID = ip_ID) then
		delete from team where ip_ID = team.ID;
	else
		signal sqlstate '45000' set message_text = 'There is no such team in the system.';
	end if;
end //
delimiter ;

change_club_captain
delimiter // 
create procedure change_club_captain (in ip_club_ID char(9),
	in ip_captain char(255), in ip_captain_ID char(9))
sp_main: begin

	-- throws exception if new club's ID doesn't exist in the system
	if not exists (select ID from team where ID = ip_club_ID) then
		signal sqlstate '45000' set message_text = 'Club does not exist in the system.';
	end if;
    
	-- throws exception when ip_captain_ID is null
	if ip_captain_ID is null then
		signal sqlstate '45000' set message_text = 'Captain_ID is null.';
	end if;
    
    -- throws exception when ip_captain_ID is not in player table
    if not exists (select ID from player where ID = ip_captain_ID) then
		signal sqlstate '45000' set message_text = 'Player does not exist in the system.';
	end if;
    
    -- throws exception when the name doesn't match the ID
    if not exists (select concat(f_name, ' ', l_name) from worker where ip_captain = concat(f_name, ' ', l_name) and ip_captain_ID = worker.ID) then
		signal sqlstate '45000' set message_text = 'Player name needs to match the ID.';
	end if;	
    
    -- throws exception if the player is currently in different club
    if not exists (select ID from worker where ip_captain_ID = worker.ID and ip_club_ID = worker.club) then
    	signal sqlstate '45000' set message_text = 'This player is currently in different team.';
	end if;	
    
    -- demote current captain by updating lead_club to false
    update player
    set lead_club = false
    where player.ID in (select ID from worker where club = ip_club_ID);
    
    -- promote new captain iff new captain name is unique among current "club" captains
	if not exists (select captain from team where ip_captain = captain and team.ID in (select ID from club_team)) then
		update team
        set captain = ip_captain
        where team.ID = ip_club_ID;
        -- update lead_club if new captain already exists in the database
        if exists (select concat(f_name, ' ', l_name) from worker where ip_captain = concat(f_name, ' ', l_name)) then
			update player
            set lead_club = true
            where player.ID in (select ID from worker where ip_captain = concat(f_name, ' ', l_name));
		end if;
	end if;	
end //
delimiter ;

participate competitions
delimiter // 
create procedure participate_competitions (in ip_team_ID char(9),
	in ip_competition char(9))
sp_main: begin
	
    -- throws exception if team_ID doesn't exist in the system.
	if not exists (select ID from team where ID = ip_team_ID) then
		signal sqlstate '45000' set message_text = 'Team_ID does not exist in the system.';
	end if;
    
    -- throws exception if competition_ID doesn't exist in the system.
	if not exists (select ID from competition where ID = ip_competition) then
		signal sqlstate '45000' set message_text = 'Competition ID does not exist in the system.';
	end if;
    
    -- throws exception if this specific paricipation is already reflected in the system.
	if exists (select teamID from participate where teamID = ip_team_ID and ip_competition = competition) then
		signal sqlstate '45000' set message_text = 'This competition is already reflected in the system.';
	end if;
    
    -- at this point, it means both team_ID and competition_ID exist in the system
    -- but not with this combination.
    -- needs to verify if team type corresponds the competition type
    if exists (select ID from national_team where ID = ip_team_ID) then
		if ip_competition = (select ID from competition where type like 'n%') then
			insert into participate values (ip_team_ID, ip_competition);
		else
			signal sqlstate '45000' set message_text = 'National team cannot participate in a club competition.';
		end if;
    elseif ip_competition = (select ID from competition where type like 'c%') then
		insert into participate values (ip_team_ID, ip_competition);
	else
		signal sqlstate '45000' set message_text = 'Club team cannot participate in a national competition.';
	end if;
end //
delimiter ;

sponsor competitions
delimiter // 
create procedure sponsor_competition (in ip_company_ID char(9),
	in ip_competition_ID char(9))
sp_main: begin
	if exists (select comp_ID from company where ip_company_ID = comp_ID) then 
		if exists (select ID from competition where ID = ip_competition_ID) then
			if not exists (select company_ID from sponsor_comp where competition = ip_competition_ID and ip_company_ID = company_ID) then
				insert into sponsor_comp values (ip_company_ID, ip_competition_ID);
			else
				signal sqlstate '45000' set message_text = 'This company is already sponsoring the competition.';
			end if;
		else
			signal sqlstate '45000' set message_text = 'Competition ID does not exist in the system.';
		end if;
	else
		signal sqlstate '45000' set message_text = 'Company ID does not exist in the system.';
    end if;
end //
delimiter ;

-- Supplementary method #2: to test out sponsor_competition with new company
add_company
delimiter // 
create procedure add_company (in ip_comp_ID char(9), in ip_comp_name char(255), in ip_address char(255))
sp_main: begin
	-- automatically throws exception if company ID is not unique // Duplicate key
	insert into company values (ip_comp_ID, ip_comp_name, ip_address, null);
end //
delimiter ;

delete_order
delimiter // 
create procedure delete_order (in ip_club_ID char(9), in ip_orderID char(9))
sp_main: begin
	-- throws exception if the unique pair of order ID and team ID is not in the system.
	if not exists (select orderID from orders where orderID = ip_orderID and club = ip_club_ID) then
		signal sqlstate '45000' set message_text = 'Cannot find this order from the system.';
	else
		delete from orders where orderID = ip_orderID and club = ip_club_ID;
	end if;
end //
delimiter ;

-- Supplementary method #3: to test out delete_order with new order
place_order
delimiter // 
create procedure place_order (in ip_orderID decimal(4,0), in ip_num_item_1 decimal(2,0), in ip_price_item_1 decimal(3,0),
  in ip_name_item_1 char(100), in ip_num_item_2 decimal(2,0), in ip_price_item_2 decimal(3,0), in ip_name_item_2 char(100),
  in ip_club char(9), in ip_selector char(9))
sp_main: begin
	-- automatically throws exception if company ID is not unique // Duplicate key
	insert into orders values (ip_orderID, ip_num_item_1, ip_price_item_1, ip_name_item_1, ip_num_item_2, ip_price_item_2, ip_name_item_2, ip_club, ip_selector);
end //
delimiter ;

-- display players who play for the national teams with world rank of top 10 in the platform
create or replace view national_players (player_ID, fname, lname) as
select worker.ID, f_name, l_name
from worker left join team on worker.country = team.country
left join national_team on team.ID = national_team.ID
where world_rank <= 10;

-- display players who scored more than 10 goals in all games of the season in the platform
create or replace view best_players (player_ID, fname, lname) as
select worker.ID, f_name, l_name
from worker left join player on worker.ID = player.ID
where num_goals > 10;

-- display the member’s information for all clubs that have a 1st rank in their country
create or replace view top_clubs (player_ID, fname, lname) as
select worker.ID, f_name, l_name
from worker left join team on worker.club = team.ID
left join club_team on team.ID = club_team.ID
where country_rank = 1;

-- display the club teams with coaches that served more than five years
create or replace view experienced_coaches (team_ID, team_name) as
select team.ID, team.name
from team left join club_team on team.ID = club_team.ID
left join worker on club_team.ID = club
left join coach on worker.ID = coach.ID
where num_years > 5;

-- display the name of companies which sponsors no player in the system
create or replace view company_sponsor (company_ID, company_name) as
select comp_ID, comp_name
from company
where endorse_player is null;
