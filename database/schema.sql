CREATE DATABASE catalog_of_things;

CREATE TABLE item(
    id SERIAL PRIMARY KEY,
    genre VARCHAR(150),
    author VARCHAR(150),
    source VARCHAR(150),
    label VARCHAR(150),
    publish_date DATE,
    archived BOOLEAN
);

CREATE TABLE label(
    id SERIAL PRIMARY KEY,
    title VARCHAR(150),
    color VARCHAR(150)
);

ALTER TABLE item ADD COLUMN label_id INTEGER REFERENCES label(id);

CREATE TABLE book(
    id INTEGER PRIMARY KEY,
    publisher VARCHAR(100),
    publish_date DATE,
    cover_state VARCHAR(100),
    item_id INTEGER,
    FOREIGN KEY(item_id) REFERENCES items(id)
);
