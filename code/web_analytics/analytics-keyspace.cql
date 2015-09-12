CREATE KEYSPACE analytics WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'};

USE analytics;

CREATE TABLE bytes_transferred (
    client_id text,
    event_timestamp text,
    frequency bigint,
    PRIMARY KEY (client_id, event_timestamp)
);

CREATE TABLE page_views (
    client_id text,
    event_timestamp text,
    frequency bigint,
    PRIMARY KEY (client_id, event_timestamp)
);

CREATE TABLE top_urls (
    client_id text,
    event_timestamp text,
    frequency bigint,
    item text,
    PRIMARY KEY (client_id, event_timestamp, frequency, item)
) WITH CLUSTERING ORDER BY (event_timestamp ASC, frequency DESC, item ASC);

CREATE TABLE top_countries (
    client_id text,
    event_timestamp text,
    frequency bigint,
    item text,
    PRIMARY KEY (client_id, event_timestamp, frequency, item)
) WITH CLUSTERING ORDER BY (event_timestamp ASC, frequency DESC, item ASC);