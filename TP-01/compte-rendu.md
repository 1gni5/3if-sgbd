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