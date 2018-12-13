use cyberlife;

# all alive lifeforms of TestWorld1
select * from lifeform_states
where (
	   state_id_fk = (select state_id from states 
					  where (states.name = 'isAlive')
                      )
	   and lifeform_id_fk in (
							  select lifeform_id 
							  from lifeforms 
                              where (world_id_fk  = (
												 select world_id 
                                                 from worlds
                                                 where (name = 'TestWorld1')
												)
									)
                              )
       )
        