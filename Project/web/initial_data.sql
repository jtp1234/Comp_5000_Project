INSERT INTO posts
	(post_id, author_id, created, post_title, post_description,
             image_url, votes)
VALUES
	(1, 1, '2018-04-21 11:56:15.46', "Doge", "Doge with sunglasses",
            "https://ih1.redbubble.net/image.264246449.9046/poster%2C210x230%2Cf8f8f8-pad%2C210x230%2Cf8f8f8.lite-1u1.jpg",
            0);
    
INSERT INTO users
        (user_id, username, created, password)
VALUES
        (1, "Meme Lord", '2018-04-20 12:51:30.56', "password1");

INSERT INTO users
        (user_id, username, created, password)
VALUES
        (2, "Memerton", '2018-04-21 12:51:30.56', "password2");

INSERT INTO comments
        (comment_id, post_id, author_id, created, comment)
VALUES
        (1, 1, 2, '2018-04-22 12:51:30.56', "Great meme!");