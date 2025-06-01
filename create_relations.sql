ALTER TABLE authors ADD CONSTRAINT authors_name_unique UNIQUE (name);
ALTER TABLE subreddits ADD CONSTRAINT subreddits_display_name_unique UNIQUE (display_name);
ALTER TABLE subreddits ADD CONSTRAINT subreddits_name_unique UNIQUE (name);


ALTER TABLE submissions ADD CONSTRAINT fk_author FOREIGN KEY (author) REFERENCES authors (name);
ALTER TABLE comments ADD CONSTRAINT fk_author FOREIGN KEY (author) REFERENCES authors (name);
ALTER TABLE comments ADD CONSTRAINT fk_subreddit_id FOREIGN KEY (subreddit_id) REFERENCES subreddits (name);
ALTER TABLE comments ADD CONSTRAINT fk_subreddit FOREIGN KEY (subreddit) REFERENCES subreddits(display_name);