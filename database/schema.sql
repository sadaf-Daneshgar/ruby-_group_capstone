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


CREATE TABLE author(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
);

CREATE TABLE game(
    id INTEGER PRIMARY KEY,
    multiplayer BOOLEAN,
    last_played_at DATE,
    item_id INTEGER,
    FOREIGN KEY(item_id) REFERENCES items(id)
);

CREATE TABLE genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200)
);

CREATE TABLE music_album (
    id INTEGER PRIMARY KEY,
    on_spotify BOOLEAN,
    publish_date DATE,
    archived BOOLEAN,
    genre_id INTEGER,
    FOREIGN KEY (genre_id) REFERENCES genre(id),
    genre_name VARCHAR(200)
);

CREATE INDEX idx_book_item_id ON book(item_id);
CREATE INDEX idx_item_label_id ON item(label_id);

