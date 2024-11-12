--! Previous: sha1:09ab924ce8d09322138ebb0f7710783d58d03966
--! Hash: sha1:57dfe25ac187045d01f861bdaa67332009e9e9dd

DO $$ BEGIN
    CREATE TYPE main.album_type AS ENUM (
        'album',
        'single',
        'compilation'
    );
    EXCEPTION WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE main.release_date_precision AS ENUM (
        'year',
        'month',
        'day'
    );
    EXCEPTION WHEN duplicate_object THEN null;
END $$;

DROP TABLE IF EXISTS main.album;
CREATE TABLE IF NOT EXISTS main.album (
    id text NOT NULL,
    name text NOT NULL,
    uri text NOT NULL,
    "type" main.album_type NOT NULL,
    total_tracks smallint,
    release_date text,
    release_date_precision main.release_date_precision,
    is_explicit bool NOT NULL DEFAULT false,
    is_market_restricted bool NOT NULL DEFAULT false,
    popularity smallint DEFAULT 0,
    genres text[] NOT NULL,
    label text NOT NULL
);

DROP TABLE IF EXISTS main.album_image;
CREATE TABLE IF NOT EXISTS main.album_image (
    album_id text NOT NULL,
    href text NOT NULL,
    width smallint,
    height smallint
);

DROP TABLE IF EXISTS main.artist;
CREATE TABLE IF NOT EXISTS main.artist (
    id text NOT NULL,
    name text NOT NULL,
    uri text NOT NULL,
    total_followers smallint,
    popularity smallint DEFAULT 0,
    genres text[] NOT NULL
);

DROP TABLE IF EXISTS main.artist_image;
CREATE TABLE IF NOT EXISTS main.artist_image (
    artist_id text NOT NULL,
    href text NOT NULL,
    width smallint,
    height smallint
);


DROP TABLE IF EXISTS main.track;
CREATE TABLE IF NOT EXISTS main.track (
    id text NOT NULL,
    album_id text NOT NULL,
    artist_ids text[] NOT NULL,
    name text NOT NULL,
    uri text NOT NULL,
    duration_ms integer NOT NULL,
    disc_number smallint NOT NULL,
    "type" main.album_type NOT NULL,
    track_number smallint,
    release_date text,
    release_date_precision main.release_date_precision,
    is_explicit bool NOT NULL DEFAULT false,
    is_market_restricted bool NOT NULL DEFAULT false,
    is_playable bool NOT NULL DEFAULT true,
    popularity smallint DEFAULT 0,
    genres text[] NOT NULL,
    label text NOT NULL
);

DROP TABLE IF EXISTS main.track_audio_feature;
CREATE TABLE IF NOT EXISTS main.track_audio_feature (
    track_id text NOT NULL,
    acousticness decimal(100, 50) NOT NULL DEFAULT 0.0,
    danceability decimal(100, 50) NOT NULL DEFAULT 0.0,
    energy decimal(100, 50) NOT NULL DEFAULT 0.0,
    instrumentalness decimal(100, 50) NOT NULL DEFAULT 0.0,
    key integer NOT NULL DEFAULT 0,
    liveness decimal(100, 50) NOT NULL DEFAULT 0.0,
    loudness decimal(100, 50) NOT NULL DEFAULT 0.0,
    is_major bool NOT NULL,
    speechiness decimal(100, 50) NOT NULL DEFAULT 0.0,
    tempo decimal(100, 50) NOT NULL DEFAULT 0.0,
    time_signature integer NOT NULL DEFAULT 0,
    valence decimal(100, 50) NOT NULL DEFAULT 0.0
);

DROP TABLE IF EXISTS main.user;
CREATE TABLE IF NOT EXISTS main.user (
    id text NOT NULL,
    display_name text NOT NULL,
    uri text NOT NULL,
    total_followers integer NOT NULL DEFAULT 0
);

DROP TABLE IF EXISTS main.user_image;
CREATE TABLE IF NOT EXISTS main.user_image (
    user_id text NOT NULL,
    href text NOT NULL,
    width smallint,
    height smallint
);

DROP TABLE IF EXISTS main.playlist;
CREATE TABLE IF NOT EXISTS main.playlist (
    id text NOT NULL,
    owner_id text NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    uri text NOT NULL,
    total_tracks integer NOT NULL DEFAULT 0,
    total_followers integer NOT NULL DEFAULT 0,
    release_date text,
    release_date_precision main.release_date_precision,
    is_public bool NOT NULL DEFAULT false,
    is_collaborative bool NOT NULL DEFAULT false
);

DROP TABLE IF EXISTS main.playlist_track;
CREATE TABLE IF NOT EXISTS main.playlist_track (
    playlist_id text NOT NULL,
    track_id text NOT NULL,
    added_at timestamp without time zone NOT NULL,
    added_by text NOT NULL
);

DROP TABLE IF EXISTS main.playlist_image;
CREATE TABLE IF NOT EXISTS main.playlist_image (
    playlist_id text NOT NULL,
    href text NOT NULL,
    width smallint,
    height smallint
);
