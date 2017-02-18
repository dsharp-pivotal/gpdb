-- @Description Ensures that a vacuum with serializable works ok
-- 
DROP TABLE IF EXISTS ao;
DROP TABLE IF EXISTS ao2;
CREATE TABLE ao (a INT, b INT) WITH (appendonly=true);
CREATE TABLE ao2 (a INT) WITH (appendonly=true);
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1, 100) AS i;

DELETE FROM ao WHERE a < 20;
1: SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
1: SELECT COUNT(*) FROM ao;
1: BEGIN;
1: SELECT COUNT(*) FROM ao2;
2: SELECT segno, tupcount FROM gp_toolkit.__gp_aoseg_name('ao');
2: VACUUM ao;
2: SELECT segno, tupcount FROM gp_toolkit.__gp_aoseg_name('ao');
1: SELECT COUNT(*) FROM ao;
1: COMMIT;
