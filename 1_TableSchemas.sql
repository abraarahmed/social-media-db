CREATE DATABASE social_media_db;
USE social_media_db;

-- Users
CREATE TABLE users
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    username   VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Photos
CREATE TABLE photos
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    image_url  VARCHAR(255) NOT NULL,
    user_id    INT          NOT NULL REFERENCES users (id),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Comments
CREATE TABLE comments
(
    id           INT AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    user_id      INT          NOT NULL REFERENCES users (id),
    photo_id     INT          NOT NULL REFERENCES photos (id),
    created_at   TIMESTAMP DEFAULT NOW()
);

-- Likes
CREATE TABLE likes
(
    user_id    INT NOT NULL REFERENCES users (id),
    photo_id   INT NOT NULL REFERENCES photos (id),
    created_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (user_id, photo_id)
);

-- Stats
CREATE TABLE stats
(
    follower_id INT NOT NULL REFERENCES users (id),
    followee_id INT NOT NULL REFERENCES users (id),
    created_at  TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (follower_id, followee_id)
);

-- Hashtags
CREATE TABLE tags
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    tag_name   VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Linking Photos & Hashtags
CREATE TABLE photo_tags
(
    photo_id INT REFERENCES photos (id),
    tag_id   INT REFERENCES tags (id),
    PRIMARY KEY (photo_id, tag_id)
);