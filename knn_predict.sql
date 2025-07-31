DELIMITER $$

CREATE PROCEDURE knn_predict (
    IN in_gdp DOUBLE,
    IN in_social DOUBLE,
    IN in_health DOUBLE,
    IN in_freedom DOUBLE,
    IN in_generosity DOUBLE
)
BEGIN
    SELECT `Country name`,
    `Ladder score`,
    (
      POW(`Explained by: Log GDP per capita` - in_gdp, 2) +
      POW(`Explained by: Social support` - in_social, 2) +
      POW(`Explained by: Healthy life expectancy` - in_health, 2) +
      POW(`Explained by: Freedom to make life choices` - in_freedom, 2) +
      POW(`Explained by: Generosity` - in_generosity, 2)
    ) AS distance
    FROM whr_raw
    ORDER BY distance ASC
    LIMIT 5;
END $$

DELIMITER ;

CALL knn_predict(1.0, 0.9, 0.8, 0.7, 0.6);
