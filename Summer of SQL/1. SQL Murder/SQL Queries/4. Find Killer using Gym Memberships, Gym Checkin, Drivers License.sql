-- Get Gym member + checkin times + drivers license
SELECT person.name, person.id FROM person 
  INNER JOIN get_fit_now_member AS member
  ON person.id = member.person_id
  INNER JOIN get_fit_now_check_in AS checkin
  ON member.id = checkin.membership_id
  INNER JOIN drivers_license 
  ON person.license_id = drivers_license.id
  
  WHERE membership_id LIKE "48Z%" AND plate_number LIKE "%H42W%" AND check_in_date = 20180109
;
