CREATE OR REPLACE TRIGGER TG_ARTISTE_NAME_IS_ONLY_UPPERCASE
BEFORE INSERT OR UPDATE ON ARTISTE
FOR EACH ROW 
BEGIN
  
  -- Passe en majuscule le nom de l'artiste
  SELECT UPPER(:NEW.NOM) INTO :NEW.NOM FROM DUAL;

END;
/

-- Essaye d'insérer un nouvel artiste avec un nom en minuscule
INSERT INTO ARTISTE (ID_ARTISTE, NOM, PRENOM, DATE_NAISSANCE)
VALUES (1, 'ford', 'Harrison', to_date('13-07-1942', 'dd-mm-yyyy'));

-- Le nom est bien passé en majuscule
SELECT * FROM ARTISTE WHERE ID_ARTISTE = 1;