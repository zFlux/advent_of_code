create table day1 (
  calories VARCHAR
);

copy day1 from '/home/daniel/input_real.txt' with delimiter '~';

create or replace function calculate_most_calories() returns INTEGER as $$
declare
	i INTEGER;
	max_sum INTEGER;
	current_sum INTEGER;
begin
	max_sum := 0;
    for i in
       select 
			case when calories = '' then '0' else calories end ::integer
	   from day1
    loop
	    if i = 0 then 
	    	current_sum := 0;
	    end if;
	    if i != 0 then
	    	current_sum := current_sum + i;
	    	if current_sum > max_sum then
	    		max_sum := current_sum;
	    	end if;
	    end if;
	 end loop;
return max_sum;
end;
$$ language plpgsql;

create or replace function calculate_top_3_calories() returns INTEGER as $$
declare
	i INTEGER;
	max_sum_one INTEGER;
	max_sum_two INTEGER;
	max_sum_three INTEGER;
	current_sum INTEGER;
begin
	max_sum_one := 0;
	max_sum_two := 0;
	max_sum_three := 0;
  	current_sum := 0;
    for i in
       select case when calories = '' then '0' else calories end ::integer
	   from day1
    loop
	    if i = 0 then 
    	    if current_sum > max_sum_one then
	    		max_sum_three := max_sum_two;
	    		max_sum_two := max_sum_one;
	    		max_sum_one := current_sum;
	    	elseif current_sum > max_sum_two then
	    		max_sum_three := max_sum_two;
	    		max_sum_two := current_sum;
	    	elseif current_sum > max_sum_three then
	    		max_sum_three := current_sum;
	    	end if;
	    	current_sum := 0;
	    end if;
	    if i != 0 then
	    	current_sum := current_sum + i;
	    end if;
	end loop;
    if current_sum > max_sum_one then
		max_sum_three := max_sum_two;
		max_sum_two := max_sum_one;
		max_sum_one := current_sum;
	elseif current_sum > max_sum_two then
		max_sum_three := max_sum_two;
		max_sum_two := current_sum;
	elseif current_sum > max_sum_three then
		max_sum_three := current_sum;
	end if;
	return max_sum_one + max_sum_two + max_sum_three;
end;
$$ language plpgsql;

select 'part 1' part, calculate_most_calories() solution
union all
select 'part 2' part, calculate_top_3_calories() solution;




