use cyberlife;

# words------------------------------------------------------------------
insert into words
set 
	`word_id`=1,
	`map`=multipoint((0.0, 0.0), (1000.0, 1000.0)),
	`name`='TestWorld1',
	`description`='Test';

# word_lifeform_sets-----------------------------------------------------
insert into word_lifeform_sets
set
	 `lifeform_set_id`=1,
	`name` = 'alive',
	`word_id_fk` = 1;

insert into word_lifeform_sets
set
	 `lifeform_set_id`= 2,
	`name` = 'organic',
	`word_id_fk` = 1;
    
# states-----------------------------------------------------------------    
insert into states
set 
	`state_id` = 1,
	`state_type` = 'bool',
    `name` = 'isAlive';

insert into states
set 
	`state_id` = 2,
	`state_type` = 'double',
    `name` = 'energy';

insert into states
set 
	`state_id` = 3,
	`state_type` = 'bool',
    `name` = 'canReproduce';

insert into states
set 
	`state_id` = 4,
	`state_type` = 'bool',
    `name` = 'isEnergyOverflow';

# phenomens-----------------------------------------------------------------
insert into phenomens
set
	`phenomen_id` = 1,
	`effect` = 4,
	`name` = 'sun',
	`state_id_fk` = 2;


insert into phenomens
set
	`phenomen_id` = 2,
	`effect` = 2,
	`name` = 'minerals',
	`state_id_fk` = 2;

# word_phenomens-------------------------------------------------------------------
insert into word_phenomens
set 
  `area` = multipoint((0,0), (1000, 500)),
  `gradient_factor`= 0,
  `power_factor` = 1,
  `phenomen_id_fk` = 1,
  `state_id_fk`  = 2,
  `word_id_fk`  = 1,
  `status`  = BIT(1),
  `period` = 0;

insert into word_phenomens
set 
  `area` = multipoint((0, 700), (1000, 1000)),
  `gradient_factor`= 1,
  `power_factor` = 1,
  `phenomen_id_fk` = 2,
  `state_id_fk`  = 2,
  `word_id_fk`  = 1,
  `status`  = BIT(1),
  `period` = 100;

# lifeforms--------------------------------------------------------------------------
insert into lifeforms
(lifeforms.genom, lifeforms.point, lifeforms.word_id_fk, lifeforms.lifeform_set_id_fk)
values ();