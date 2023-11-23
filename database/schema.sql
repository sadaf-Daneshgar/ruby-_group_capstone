CREATE DATABASE catalog_of_things;

CREATE TABLE item (
    id SERIAL PRIMARY KEY,
    genre_id INTEGER,
    author_id INTEGER,
    label_id INTEGER,
    publish_date DATE,
    archived BOOLEAN,
    FOREIGN KEY (genre_id) REFERENCES genre (id),
    FOREIGN KEY (author_id) REFERENCES author (id),
    FOREIGN KEY (label_id) REFERENCES label (id)
);

CREATE TABLE label (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150),
    color VARCHAR(150)
);

CREATE TABLE book (
    id INTEGER PRIMARY KEY,
    publisher VARCHAR(100),
    publish_date DATE,
    cover_state VARCHAR(100),
    item_id INTEGER,
    FOREIGN KEY (item_id) REFERENCES item (id)
);

CREATE TABLE author (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

CREATE TABLE game (
    id INTEGER PRIMARY KEY,
    multiplayer BOOLEAN,
    last_played_at DATE,
    item_id INTEGER,
    FOREIGN KEY (item_id) REFERENCES item (id)
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
    FOREIGN KEY (genre_id) REFERENCES genre (id),
    genre_name VARCHAR(200)
);

CREATE INDEX idx_book_item_id ON book(item_id);
CREATE INDEX idx_item_genre_id ON item(genre_id);
CREATE INDEX idx_item_author_id ON item(author_id);
CREATE INDEX idx_item_label_id ON item(label_id);
CREATE INDEX idx_game_item_id ON game(item_id);
CREATE INDEX idx_music_album_genre_id ON music_album(genre_id);
