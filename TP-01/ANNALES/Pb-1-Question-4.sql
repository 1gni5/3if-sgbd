ALTER TABLE SALLE MODIFY CAPACITE NUMBER CHECK (CAPACITE >= 30);

-- Ajoute un cinéma auquel la salle de test va appartenir
INSERT INTO CINEMA (ID_CINEMA, NOM, ARRONDISSEMENT, ADRESSE)
VALUES (1, 'LE GRAND REX', '2nd', '1 bd Poissonniere, Paris, FR ');

-- Essaye d'insérer une nouvelle salle avec une capacité de 25
INSERT INTO SALLE (NUMERO, CINEMA, CAPACITE)
VALUES (1, 1, 25);