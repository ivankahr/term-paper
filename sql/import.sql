INSERT INTO users SET name = 'root', admin = 1;
INSERT INTO tests SET name = 'first test';
INSERT INTO questions (content, test_id) VALUES ('first question?', 1);
INSERT INTO answers (content, correct, question_id) VALUES
    ('answer 1', false, 1),
    ('answer 2 (correct)', true, 1);
