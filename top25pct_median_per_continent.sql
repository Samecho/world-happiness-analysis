DROP VIEW IF EXISTS top25pct_median_per_continent;

CREATE VIEW top25pct_median_per_continent AS
SELECT *
FROM (
    SELECT 
        "Country name",
        c.name AS "continent",
        "Ladder score",
        RANK() OVER(PARTITION BY c.name ORDER BY "Ladder score" DESC) AS Score_rank,
        RANK() OVER(PARTITION BY c.name ORDER BY "Explained by: Log GDP per capita" DESC) AS Gdp_rank,
        RANK() OVER(PARTITION BY c.name ORDER BY "Explained by: Social support" DESC) AS Social_rank,
        RANK() OVER(PARTITION BY c.name ORDER BY "Explained by: Healthy life expectancy" DESC) AS Health_rank,
        RANK() OVER(PARTITION BY c.name ORDER BY "Explained by: Freedom to make life choices" DESC) AS Freedom_rank,
        RANK() OVER(PARTITION BY c.name ORDER BY "Explained by: Generosity" DESC) AS Generosity_rank,
        RANK() OVER(PARTITION BY c.name ORDER BY "Explained by: Perceptions of corruption" DESC) AS Corruption_rank,
        COUNT(*) OVER(PARTITION BY c.name) AS total_countries
    FROM whr_raw whr
    JOIN continents c ON whr.continent_id = c.id
) AS ranked
WHERE Gdp_rank <= floor(0.25 * total_countries)
  AND Social_rank <= floor(0.25 * total_countries)
  AND Health_rank <= floor(0.25 * total_countries)
  AND Freedom_rank <= floor(0.25 * total_countries)
  AND Generosity_rank <= floor(0.25 * total_countries)
  AND Corruption_rank < floor(0.75 * total_countries);
