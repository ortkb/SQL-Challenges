SELECT id,
       name,
       license_id,
       MAX(address_number),
       address_street_name,
       ssn
FROM person
WHERE address_street_name = "Northwestern Dr"