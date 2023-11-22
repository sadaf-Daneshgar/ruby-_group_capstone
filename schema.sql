CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  publish_date DATE NOT NULL,
  archived BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE music_albums (
  id SERIAL PRIMARY KEY,
  on_spotify BOOLEAN NOT NULL,
  genre_id INTEGER REFERENCES genres(id),
  item_id INTEGER REFERENCES items(id)
);

CREATE TABLE genres (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);
