-- Toutes les tailles sont choisies de manière arbitraire
-- en temps normal elles sont à demander au client.

CREATE TABLE CINEMA (
    
    ID_CINEMA NUMBER(10),
    NOM VARCHAR2(50),
    ARRONDISSEMENT VARCHAR2(80),
    ADRESSE VARCHAR2(100),
  
    CONSTRAINT PK_CINEMA PRIMARY KEY(ID_CINEMA)
);

CREATE TABLE SALLE (

    NUMERO NUMBER(5),
    CINEMA NUMBER(10),
    CAPACITE NUMBER(3),
    
    CONSTRAINT PK_SALLE PRIMARY KEY (NUMERO, CINEMA),
    CONSTRAINT FK_SALLE_CINEMA FOREIGN KEY (CINEMA) 
    REFERENCES CINEMA (ID_CINEMA)
);

CREATE TABLE ARTISTE (
    
    ID_ARTISTE NUMBER(10), -- À vérifier avec le client
    NOM VARCHAR2(30),
    PRENOM VARCHAR2(30),
    DATE_NAISSANCE DATE,
    
    CONSTRAINT PK_ARTISTE PRIMARY KEY (ID_ARTISTE)
);

CREATE TABLE FILM (

    ID_FILM NUMBER(10),
    TITRE VARCHAR2(30),
    DATE_SORTIE DATE,
    REALISATEUR NUMBER(10),
    
    CONSTRAINT PK_FILM PRIMARY KEY (ID_FILM),
    CONSTRAINT FK_FILM_ARTISTE FOREIGN KEY (REALISATEUR)
    REFERENCES ARTISTE (ID_ARTISTE)
);

CREATE TABLE ROLE (

    FILM NUMBER(10),
    ACTEUR NUMBER(10),
    ROLE VARCHAR2(30),
    
    CONSTRAINT PK_ROLE PRIMARY KEY (FILM, ACTEUR),
    CONSTRAINT FK_ROLE_FILM FOREIGN KEY (FILM)
    REFERENCES FILM (ID_FILM),
    CONSTRAINT FK_ROLE_ARTISTE FOREIGN KEY (ACTEUR)
    REFERENCES ARTISTE (ID_ARTISTE)
);

CREATE TABLE PROJECTION (

    FILM NUMBER(10),
    CINEMA NUMBER(10),
    SALLE NUMBER(10),
    DATE_PROJECTION DATE,
    HEURE_DEBUT DATE,
    HEURE_FIN DATE,
    
    -- ATTENTION ! Par du principe qu'une salle peut projecter plusieurs fois
    -- le même film à des horaires différents.
    
    CONSTRAINT PK_PROJECTION PRIMARY KEY 
    (FILM, CINEMA, SALLE, DATE_PROJECTION, HEURE_DEBUT),
    
    CONSTRAINT FK_PROJECTION_FILM FOREIGN KEY (FILM)
    REFERENCES FILM (ID_FILM),
    CONSTRAINT FK_PROJECTION_SALLE FOREIGN KEY (CINEMA, SALLE)
    REFERENCES SALLE (CINEMA, NUMERO)
);