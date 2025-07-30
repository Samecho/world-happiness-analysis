CREATE TABLE continents (
    id TINYINT UNSIGNED PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE
);

INSERT INTO continents (id, name) VALUES
(1, 'Africa'),
(2, 'Asia'),
(3, 'Europe'),
(4, 'North America'),
(5, 'Oceania'),
(6, 'South America');
