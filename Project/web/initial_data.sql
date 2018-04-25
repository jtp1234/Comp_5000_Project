INSERT INTO books
	(book_id, topic_id, book_name, author_id, is_available)
VALUES
	(1, 1, "Intro XML", 1, true);
    
INSERT INTO books
	(book_id, topic_id, book_name, author_id, is_available)
VALUES
    (2, 1, "Basic XML", 2, true);

INSERT INTO books
	(book_id, topic_id, book_name, author_id, is_available)
VALUES
    (3, 2, "Intro JSP", 2, true);
    
INSERT INTO books
	(book_id, topic_id, book_name, author_id, is_available)
VALUES
    (4, 2, "Basic JSP", 1, true);
    
INSERT INTO topics
	(topic_id, topic_name)
VALUES
	(1, "XML");
    
INSERT INTO topics
	(topic_id, topic_name)
VALUES
    (2, "JSP");
    
INSERT INTO authors
	(author_id, author_name)
VALUES
	(1, "Tim Bray");
    
INSERT INTO authors
	(author_id, author_name)
VALUES
    (2, "Bert Bos");