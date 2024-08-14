use ig_clone;
-- create an ER diagram or draw a schema for the given database.
-- Database> Reverse Engineer> continue> give password >execute

-- We want to reward the user who has been around the longest,find the 5 oldest users.
select username,created_at  from users
order by created_at
limit 5;

-- To target inactive users in an email ad campaign,find the users who have never posted a photo.
select username from users u left join photos p on u.id=p.user_id
where p.user_id is null;
select *from users where id not in (select user_id from photos); 

-- Suppose you are running a contest to find out who got the most likes on a photo.Find out who won?
select l.photo_id,u.username,count(l.user_id)count from likes l inner join photos p on p.id=l.photo_id 
inner join users u on u.id=p.user_id group by u.username,l.photo_id order by count(l.user_id) desc;

-- A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
select tag_name,count(photo_id)count from tags t inner join photo_tags pt on t.id=pt.tag_id 
group by tag_name order by count desc limit 5 ;


-- To find out if there are bots, find users who have liked every single photo on the site.
select count(photo_id)as count,user_id,username from likes l inner join users u on l.user_id=u.id 
group by user_id,username order by count desc ;

-- Find the users who have created instagramid in may and select top 5 newest joinees from it
select username,created_at from users  where monthname(created_at) ='May' order by created_at desc limit 5;

-- Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?
select username from users u inner join photos p on u.id=p.id 
inner join likes l on l.user_id=p.user_id
where username regexp '^c.*[0-9]$' group by username;
select * from users;
select * from photos;

-- Demonstrate the top 30 usernamesof company who have posted photos in range of 3 to 5. 
select count(user_id) as count,username from users u inner join photos p on u.id=p.user_id 
group by username having count between 3 and 5 limit 30;