SELECT "Country name",
    "Ladder score", 
    CASE 
        WHEN "Ladder score" >= (
        SELECT AVG("Ladder score") 
        FROM whr_raw 
        WHERE "Ladder score" >= (
        SELECT AVG("Ladder score")
        FROM whr_raw))
        THEN 'Very Happy'

        WHEN "Ladder score" > (
        SELECT AVG("Ladder score")
        FROM whr_raw)
        THEN 'Happy'

        WHEN "Ladder score" < (
        SELECT AVG("Ladder score") 
        FROM whr_raw 
        WHERE "Ladder score" < (
        SELECT AVG("Ladder score")
        FROM whr_raw))
        THEN 'Very Sad'

        WHEN "Ladder score" <= (
        SELECT AVG("Ladder score")
        FROM whr_raw)
        THEN 'Sad'
    END AS "Happiness_Index"
        
FROM whr_raw;
