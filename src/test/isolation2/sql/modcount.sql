-- @Description Tests that DML operatins change the modification count.
-- 
DROP TABLE IF EXISTS ao;
CREATE TABLE ao (a INT, b INT) WITH (appendonly=true);
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,10) AS i;

SELECT state, tupcount, modcount FROM gp_toolkit.__gp_aoseg_name('ao');
INSERT INTO ao VALUES (11, 11);
SELECT state, tupcount, modcount FROM gp_toolkit.__gp_aoseg_name('ao');
DELETE FROM ao WHERE a = 11;
SELECT state, tupcount, modcount FROM gp_toolkit.__gp_aoseg_name('ao');
UPDATE AO SET b = 0 WHERE a = 10;
SELECT state, tupcount, modcount FROM gp_toolkit.__gp_aoseg_name('ao');
