# Bases de Données Relationnelles : TP 1 SQL/PL

## Création et importation:
Création des schémas de table et importation des données.
```sql
-- Création du schéma 
@full-path\mondial-schema.sql"

-- Insertion des données
@full-path\mondial-inputs.sql"
```

## Problème 1
1. Ajout d'une clé étrangère de `Country` -> `City`.
```sql
ALTER TABLE Country
    ADD CONSTRAINT fkCountryCapitalIsCity
    FOREIGN KEY (Capital, Code, Province)
    REFERENCES City (Name, Country, Province);
```

2. La contrainte est déjà appliquée.
```sql
-- UNIQUE assure que chaque nom est unique.
Name VARCHAR2(50) NOT NULL UNIQUE
```

3. La contrainte est déjà appliquée.
```sql
-- NOT NULL assure que chaque nom est connu.
Name VARCHAR2(50) NOT NULL UNIQUE
```

4. Ajout d'une clé étrangère de `Province` -> `City`.
```sql
ALTER TABLE Province
    ADD CONSTRAINT fkProvinceCapitalIsCity
    FOREIGN KEY (Capital, Country, CapProv)
    REFERENCES City(Name, Country, Province);
```

5. Ajout d'une clé étrangère de `Province` -> `Country`.
```sql
ALTER TABLE Province
    ADD CONSTRAINT fkPovinceCountryIsCountry
    FOREIGN KEY(Country)
    REFERENCES Country(Code);
```

6. Ajout d'une clé étrangère de `City` -> `Country`.
```sql
ALTER TABLE City
    ADD CONSTRAINT fkCityCountryIsCountry
    FOREIGN KEY(Country)
    REFERENCES Country(Code);
```

7. Ajout d'une clé étrangère de `City` -> `Province`.
```sql
ALTER TABLE City
    ADD CONSTRAINT fkCityProvinceIsProvince
    FOREIGN KEY(Province, Country)
    REFERENCES Province(Name,Country);
```

8. La contrainte est déjà appliquée.
```sql
-- Assure que la longueur de la frontière est positive.
Length NUMBER CHECK (Lenght > 0)
```
9. Ajout d'une contrainte UNIQUE sur la longitude et la latitude.
```sql
ALTER TABLE City
    ADD CONSTRAINT cityPositionIsUnique
    UNIQUE (Longitude, Latitude);
```

L'application de la contrainte n'est pas possible, les données déjà présente ne la validant pas.
```sql
SELECT *
-- Récupère tout les tuples avec les même coordonnées.
FROM City c1 JOIN City c2 ON (c1.Longitude = c2.Longitude AND c1.Latitude = c2.Latitude)

-- Si il ne s'agit pas du même tuple.
WHERE c1.Name <> c2.Name OR c1.Country <> c2.Country OR c1.Province <> c2.Province;
```
> Attention, tout les tuples sont en double !

## Problème 2
1. Liste tout les pays par ordre alphabétique du nom.
```sql
SELECT * FROM Country
ORDER BY Name ASC;
```

2. Récupère la liste des organisations avec le plus de membres.
```sql
SELECT Organization, COUNT(*) NbMembres FROM isMember
GROUP BY Organization
HAVING COUNT(*) = (
    -- Récupère le nombre maximal de membres
    SELECT MAX(COUNT(*)) NbMaxMembre FROM isMember
    GROUP BY Organization
);
```

3. Récupère le pourcentage d'habitant citadin d'un Pays
```sql
-- Pourcentage de la population citadine
SELECT Country.Name, (SUM(City.Population) / Country.population) * 100 PopCitadine
FROM Country JOIN City ON Country.code = City.Country
WHERE Country.Population IS NOT NULL AND City.Population IS NOT NULL
GROUP BY (Country.name, Country.population);
```

4. Affiche la population de chaque continent, triée par ordre croissant.
```sql
SELECT Encompasses.continent, SUM(Country.Population * (Encompasses.percentage / 100)) Population
FROM Encompasses JOIN Country ON Encompasses.country = Country.code
GROUP BY (Encompasses.continent)
ORDER BY Population DESC;
```

5. Lister les pays présentant la plus longue frontière
```sql
SELECT NAME, SUM(LENGTH) FROM BORDERS
JOIN COUNTRY ON COUNTRY1=CODE
GROUP BY (NAME) ORDER BY (SUM(LENGTH)) DESC;
```

6. Lister les nom des villes qui apparaissent dans plusieurs pays, avec le nombre d'occurences
```sql
SELECT NAME, Count(country) FROM CITY
GROUP BY NAME
ORDER BY COUNT(COUNTRY) DESC;
```

7. Lister les pays dont on connait pas la date d'indépendance
```sql
SELECT CODE, NAME FROM POLITICS
JOIN COUNTRY ON COUNTRY = CODE
WHERE INDEPENDENCE IS NULL;
```

8. Lister les pays qui ne sont membres d'aucune organization
```sql
SELECT * FROM
(SELECT CODE FROM COUNTRY) MINUS (SELECT COUNTRY FROM ISMEMBER);
```

9. Lister les organisations de chaque pays, même ceux qui ne sont membre d'aucune orga
```sql
SELECT NAME, ORGANIZATION FROM
COUNTRY LEFT OUTER JOIN ISMEMBER ON CODE=COUNTRY;
```

10. Longueurs totales des frontières de chaque continent
```sql
SELECT E1.CONTINENT, SUM(LENGTH) FROM BORDERS 
JOIN ENCOMPASSES E1 ON COUNTRY1=E1.COUNTRY
JOIN ENCOMPASSES E2 ON COUNTRY2=E2.COUNTRY
WHERE E1.CONTINENT = E2.CONTINENT
GROUP BY (E1.CONTINENT)
ORDER BY SUM(LENGTH) DESC;
```

13. Donner la moyenne du nombres d'organizations siégeant dans une ville pour les villes accueillant au moins un siège d'organisation
```sql
SELECT AVG(NBORGA) FROM 
  (SELECT CITY, COUNT(*) AS NBORGA FROM ORGANIZATION
  WHERE CITY IS NOT NULL
  GROUP BY (CITY)
  ORDER BY COUNT(*) DESC);
```

14. Lister les 5 langues les plus parlées avec le nombre de personnes
```sql
SELECT LANGUAGE.NAME, SUM(POPULATION * PERCENTAGE / 100) AS NBPEOPLEWHOSPEAKTHIS FROM 
LANGUAGE JOIN COUNTRY ON COUNTRY=CODE
GROUP BY (LANGUAGE.NAME)
ORDER BY (NBPEOPLEWHOSPEAKTHIS) DESC;
```

16.
    1-la clé primaire est Country, le type d'index posé est normal.
    2- Appuyez sur le bouton plan d'exécution (F10)
       Un index est utilisé dans le plan d'exécution : COUNTRYKEY
    3- Pas d'index
    4- ```sql
        SELECT * FROM POPULATION WHERE POPULATION_GROWTH = 0;
        ```
    5- ```sql
        CREATE INDEX SUPER_INDEX ON POPULATION (POPULATION_GROWTH);
        ```
    6- Cela marche de même, nonobstant il est obligatoire de drop en premier lieu le premier index, avant de créer le nouveau
        ```sql
        CREATE INDEX SUPER_INDEX ON POPULATION (POPULATION_GROWTH);
        DROP INDEX SUPER_INDEX;

        CREATE BITMAP INDEX THE_MIC ON POPULATION (POPULATION_GROWTH);
        DROP INDEX THE_MIC;
        ```
    7- l'index "the_mic" n'est pas utilisé pour cette requête, toutefois l'index "super_index" est utilisé.

17.
```sql

```
