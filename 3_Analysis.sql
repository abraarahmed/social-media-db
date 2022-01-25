-- 1. Find oldest users
SELECT *
FROM users
ORDER BY created_at
LIMIT 10;

-- 2. Find hottest registration day of the week
SELECT DAYNAME(created_at) AS day, COUNT(*) AS total_registrations
FROM users
GROUP BY day
ORDER BY total_registrations DESC
LIMIT 1;

-- 3. Identify inactive users (without any upload)
SELECT username
FROM users
         LEFT JOIN photos p ON users.id = p.user_id
WHERE p.id IS NULL;

-- 4. Identify most active users
SELECT username, COUNT(*) AS posts
FROM users
         INNER JOIN photos p ON users.id = p.user_id
GROUP BY username
ORDER BY posts DESC
LIMIT 3;

-- 5. Find most liked photo of a user
SELECT u.username, photos.id, photos.image_url, COUNT(*) AS photo_likes
FROM photos
         INNER JOIN likes l ON photos.id = l.photo_id
         INNER JOIN users u ON photos.user_id = u.id
GROUP BY photos.id
ORDER BY photo_likes DESC
LIMIT 1;

-- 6. Identify most liked users
SELECT u.username, photos.user_id, COUNT(*) AS total_likes
FROM photos
         INNER JOIN likes l ON photos.id = l.photo_id
         INNER JOIN users u ON photos.user_id = u.id
GROUP BY photos.user_id
ORDER BY total_likes DESC
LIMIT 3;

-- 7. Calculate average post(s) per user
SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS average_posts_per_user;

-- 8. Find top hashtags
SELECT t.tag_name, COUNT(*) AS total_occurences
FROM photo_tags
         INNER JOIN tags t ON photo_tags.tag_id = t.id
GROUP BY tag_id
ORDER BY total_occurences DESC
LIMIT 5;

-- 9. Find users who have liked every photo on the site
SELECT username, COUNT(*) AS total_likes
FROM users
         INNER JOIN likes l ON users.id = l.user_id
GROUP BY l.user_id
HAVING total_likes = (SELECT COUNT(*) FROM photos);

-- 10. Find most commented photo
SELECT photos.id, photos.image_url, COUNT(*) AS total_comments
FROM photos
         INNER JOIN comments c ON photos.id = c.photo_id
GROUP BY photos.id
ORDER BY total_comments DESC
LIMIT 1;