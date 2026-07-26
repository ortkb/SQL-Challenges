SELECT id,
       name,
       license_id,
       address_number,
       address_street_name,
       ssn
FROM person
WHERE address_street_name = "Franklin Ave" AND name LIKE "Annabel%"