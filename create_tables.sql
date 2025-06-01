CREATE TABLE authors (
    id TEXT PRIMARY KEY,
    retrieved_on INTEGER,
    name TEXT,
    created_utc INTEGER,
    link_karma INTEGER,
    comment_karma INTEGER,
    profile_img TEXT,
    profile_color TEXT,
    profile_over_18 BOOLEAN
);


CREATE TABLE subreddits (
    banner_background_image  VARCHAR(255),
    created_utc              INT,
    description              TEXT,
    display_name             VARCHAR(255),
    header_img               VARCHAR(255),
    hide_ads                 VARCHAR(255),
    id                       VARCHAR(255) PRIMARY KEY,
    over18                   VARCHAR(255),
    public_description       TEXT,
    retrieved_utc            INT,
    name                     VARCHAR(255),
    subreddit_type           VARCHAR(255),
    subscribers              FLOAT,
    title                    TEXT,
    whitelist_status         VARCHAR(255)
);


CREATE TABLE submissions (
    downs INTEGER,
    url TEXT,
    id TEXT PRIMARY KEY,
    edited BOOLEAN,
    num_reports INTEGER,
    created_utc INTEGER,
    name TEXT,
    title TEXT,
    author TEXT,
    permalink TEXT,
    num_comments INTEGER,
    likes BOOLEAN,
    subreddit_id TEXT,
    ups INTEGER
);

CREATE TABLE comments (
    distinguished           VARCHAR(255),
    downs                   INT,
    created_utc             INT,
    controversiality        INT,
    edited                  BOOLEAN,
    gilded                  INT,
    author_flair_css_class  VARCHAR(255),
    id                      VARCHAR(255) PRIMARY KEY,
    author                  VARCHAR(255),
    retrieved_on            INT,
    score_hidden            BOOLEAN,
    subreddit_id            VARCHAR(255),
    score                   INT,
    name                    VARCHAR(255),
    author_flair_text       VARCHAR(255),
    link_id                 VARCHAR(255),
    archived                BOOLEAN,
    ups                     INT,
    parent_id               VARCHAR(255),
    subreddit               VARCHAR(255),
    body                    TEXT
);
