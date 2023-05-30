SHOW DATABASES;
USE ig_clone;
SHOW TABLES;

-- 1 What are the top 5 users with the highest number of photos?
SELECT * FROM photos;

SELECT * FROM users 
JOIN photos ON users.id = photos.user_id;

SELECT users.id, username, COUNT(*) AS photo_count FROM users 
JOIN photos ON users.id = photos.user_id
GROUP BY users.id 
ORDER BY photo_count DESC 
LIMIT 5;

-- 2 How many comments does each photo have on average?
SELECT * FROM comments;
-- Calculating the number of comments each post has 
SELECT photo_id, COUNT(*) FROM comments
GROUP BY photo_id;
-- Calculating the average of this count using subquery 
SELECT AVG(comments_count) FROM 
(
SELECT COUNT(*) AS comments_count FROM comments GROUP BY photo_id
) comments;


-- 3  Which user has the most comments overall?
-- first find the photo with the most comments 
SELECT photo_id, COUNT(*) comments_count FROM comments
GROUP BY photo_id
ORDER BY comments_count DESC;
-- we know the photo with photo_id 13 has the most comments (39) (note there are two other photos with this number of comments but will be ignored for simplicty)
-- next we want to join the photos and users table 
SELECT * FROM photos
JOIN comments ON photos.id = comments.photo_id
JOIN users ON users.id = photos.user_id;

SELECT username, photo_id, COUNT(*) as comment_count FROM photos
JOIN comments ON photos.id = comments.photo_id
JOIN users ON users.id = photos.user_id
GROUP BY comments.photo_id
ORDER BY comment_count DESC
LIMIT 1;
-- username = Harley_Lind16 photo_id = 13 comment_count = 39 

-- 4 What is the average number of likes per user?
SELECT * FROM likes;
SELECT * FROM photos;

-- the number of likes each photo has 
SELECT likes.photo_id, COUNT(*) FROM likes
JOIN photos on Photos.id = likes.photo_id
GROUP BY photos.id;

-- the number of likes grouped by user 
SELECT users.id, likes.photo_id, COUNT(*) AS likes_count FROM photos
JOIN likes on photos.id = likes.photo_id
JOIN users on photos.user_id = users.id
GROUP BY photos.id, users.id;

-- find the average likes per user 
SELECT users.id, AVG(likes_count) AS avg_likes_per_user
 FROM (
	SELECT photos.user_id, COUNT(*) AS likes_count 
    FROM photos
	JOIN likes on photos.id = likes.photo_id
	GROUP BY photos.user_id, photos.id
) AS likes_per_photo
JOIN users ON users.id = likes_per_photo.user_id
GROUP BY users.id;



-- 5 How many followers does each user have on average?
SHOW tables;
SELECT * FROM follows;
-- find how many followers each followee has
SELECT followee_id, COUNT(*) AS follower_count FROM follows
GROUP by followee_id;
-- finding the average of this count 
SELECT ROUND(AVG(follower_count),2) FROM 
(
SELECT COUNT(*) AS follower_count FROM follows
GROUP by followee_id
) follows;
-- 76.23



-- 6 Which user has the most followers?
-- find how many followers each followee has
SELECT followee_id, COUNT(*) AS follower_count FROM follows
GROUP by followee_id
ORDER BY follower_count DESC
LIMIT 1;
-- for this we have followee_id 1 and follower_count 77 so will use this to check the code 
SELECT username, users.id, COUNT(*) as follower_count FROM users
LEFT JOIN follows ON users.id = followee_id
GROUP BY users.id
ORDER BY follower_count DESC
LIMIT 1 ;
-- username: Kenton_kirlin id: 1 follower_count :77 


-- 7 How many unique tags are there in the dataset?
SELECT * FROM photo_tags;
SELECT MAX(tag_id) FROM photo_tags;


-- 8 What are the top 5 most commonly used tags?
SELECT * FROM photo_tags;
SELECT * FROM tags;
-- finding the most common 
SELECT COUNT(*) AS tag_count FROM photo_tags
GROUP BY tag_id
ORDER BY tag_count DESC;
-- joining the tag table 
SELECT * FROM photo_tags
JOIN tags ON tags.id = photo_tags.tag_id;
 
-- calculating the top tags from joint table 
SELECT tag_name, tag_id, COUNT(*) AS tag_count
FROM photo_tags
JOIN tags ON tags.id = photo_tags.tag_id
GROUP BY tag_id
ORDER BY tag_count DESC
LIMIT 5;
-- the top 5 most commonly used hashtags are smile, beach, party, fun and concert. 


-- 9 Which user has the highest average number of likes per photo?
SELECT * FROM likes;
SELECt * FROM photos
JOIN likes on photos.id = likes.photo_id;

SELECt * FROM photos
JOIN likes on photos.id = likes.photo_id;



-- 10 How many photos have been uploaded on each day of the week on average?
SHOW tables;
SELECT DAYNAME(created_at) AS posted_day, COUNT(*) AS day_count FROM photos
GROUP BY posted_day;

SELECT COUNT(*) From photos;
