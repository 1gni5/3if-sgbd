SELECT COUNT(*) FROM ORGANIZATION ORG1
JOIN ISMEMBER MEM1 ON ORG1.ABBREVIATION = MEM1.ORGANIZATION
WHERE ORG1.COUNTRY NOT IN -- Pays du siège social 
(SELECT COUNTRY FROM ISMEMBER MEM2 WHERE MEM2.ORGANIZATION=ORG1.ABBREVIATION); -- Pays membres