--! Previous: -
--! Hash: sha1:09ab924ce8d09322138ebb0f7710783d58d03966

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA IF NOT EXISTS public;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'Default public schema - Unused';

--
-- Name: main; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA IF NOT EXISTS main;

--
-- Name: SCHEMA main; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA main IS 'LIVE DATA schema';

--
-- Name: truss; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA IF NOT EXISTS truss;

--
-- Name: SCHEMA truss; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA truss IS 'stored scaffolding procedures schema - NO DATA / NO NON-UTILITY TABLES';

-- EXTENSION RESET

DROP EXTENSION IF EXISTS pg_trgm CASCADE;
DROP EXTENSION IF EXISTS btree_gist CASCADE;
DROP EXTENSION IF EXISTS plpgsql CASCADE;
DROP EXTENSION IF EXISTS citext CASCADE;


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA main;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA main;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


-- CONTENT

--
-- Name: init_column_btree(text, text, text); Type: FUNCTION; Schema: truss; Owner: -
--

CREATE OR REPLACE FUNCTION truss.init_column_btree(schema_name TEXT, table_name TEXT, column_name TEXT) RETURNS VOID
    LANGUAGE plpgsql
AS
$$
BEGIN
    EXECUTE 'CREATE INDEX IF NOT EXISTS ' || table_name || '_' || column_name || '_btree_idx on ' || schema_name || '.' || table_name || ' (' || column_name || ')';
END;
$$;

--
-- Name: init_column_gist(text, text, text); Type: FUNCTION; Schema: truss; Owner: -
--

CREATE OR REPLACE FUNCTION truss.init_column_gist(schema_name text, table_name text, column_name text) RETURNS void
    LANGUAGE plpgsql
AS
$$
BEGIN
    EXECUTE 'CREATE INDEX IF NOT EXISTS ' || table_name || '_' || column_name || '_gist_idx on ' || schema_name || '.' || table_name || ' USING gist (' || column_name || ')';
END;
$$;


--
-- Name: drop_column_gist(text, text, text); Type: FUNCTION; Schema: truss; Owner: -
--

CREATE OR REPLACE FUNCTION truss.drop_column_btree(schema_name TEXT, table_name TEXT, column_name TEXT) RETURNS VOID
    LANGUAGE plpgsql
AS
$$
BEGIN
    EXECUTE 'DROP INDEX IF EXISTS ' || table_name || '_' || column_name || '_idx';
END;
$$;


--
-- Name: drop_column_gist(text, text, text); Type: FUNCTION; Schema: truss; Owner: -
--

CREATE OR REPLACE FUNCTION truss.drop_column_gist(schema_name TEXT, table_name TEXT, column_name TEXT) RETURNS VOID
    LANGUAGE plpgsql
AS
$$
BEGIN
    EXECUTE 'DROP INDEX IF EXISTS ' || table_name || '_' || column_name || '_gist_idx';
END;
$$;


-- PERMISSIONS
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO spoti;
GRANT ALL ON SCHEMA main TO spoti;
GRANT ALL ON SCHEMA truss TO spoti;
