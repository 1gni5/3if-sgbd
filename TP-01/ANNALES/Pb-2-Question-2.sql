SELECT COUNTRY.NAME, SUM(BORDERS.LENGTH) AS BORDER_LENGTH FROM COUNTRY
LEFT OUTER JOIN BORDERS ON -- Nécessaire pour récupérer les pays sans frontière
(COUNTRY.CODE = BORDERS.COUNTRY1 OR COUNTRY.CODE = BORDERS.COUNTRY2) -- La table frontière est asymétrique
GROUP BY COUNTRY.NAME ORDER BY SUM(BORDERS.LENGTH) DESC;