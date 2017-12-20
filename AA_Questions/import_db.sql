DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users (id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  questions_id INTEGER NOT NULL,
  users_id INTEGER NOT NULL,

  FOREIGN KEY (users_id) REFERENCES users(id),
  FOREIGN KEY (questions_id) REFERENCES questions(id)

);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  questions_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (questions_id) REFERENCES questions(id)
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  likes INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  questions_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users (id)
  FOREIGN KEY (questions_id) REFERENCES questions (id)
);


INSERT INTO
  users (fname, lname)
VALUES
  ('Tom', 'Hanks'),
  ('John', 'Doe'),
  ('Jane', 'Doe');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Q1', 'wut is a sql', 0),
  ('Q2', 'do you like cookies', 2);

INSERT INTO
  question_follows (questions_id, users_id)
VALUES
  (0, 0),
  (0, 2),
  (1, 1);

INSERT INTO
  replies (body, questions_id, parent_reply_id, user_id)
VALUES
  ('cool story bro', 0, NULL, 0),
  ('Yes', 1 , NULL, 2),
  ('Cookies are fat', 1, 1, 1);

  INSERT INTO
    question_likes (likes,questions_id,user_id)
  VALUES
    (2,0,1),
    (3,1,2);
