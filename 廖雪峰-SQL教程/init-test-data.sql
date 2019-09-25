-- ���test���ݿⲻ���ڣ��ʹ���test���ݿ⣺
CREATE DATABASE IF NOT EXISTS test;

-- �л���test���ݿ�
USE test;

-- ɾ��classes���students��������ڣ���
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS students;

-- ����classes��
CREATE TABLE classes (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ����students��
CREATE TABLE students (
    id BIGINT NOT NULL AUTO_INCREMENT,
    class_id BIGINT NOT NULL,
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(1) NOT NULL,
    score INT NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ����classes��¼��
INSERT INTO classes(id, name) VALUES (1, 'һ��');
INSERT INTO classes(id, name) VALUES (2, '����');
INSERT INTO classes(id, name) VALUES (3, '����');
INSERT INTO classes(id, name) VALUES (4, '�İ�');

-- ����students��¼��
INSERT INTO students (id, class_id, name, gender, score) VALUES (1, 1, 'С��', 'M', 90);
INSERT INTO students (id, class_id, name, gender, score) VALUES (2, 1, 'С��', 'F', 95);
INSERT INTO students (id, class_id, name, gender, score) VALUES (3, 1, 'С��', 'M', 88);
INSERT INTO students (id, class_id, name, gender, score) VALUES (4, 1, 'С��', 'F', 73);
INSERT INTO students (id, class_id, name, gender, score) VALUES (5, 2, 'С��', 'F', 81);
INSERT INTO students (id, class_id, name, gender, score) VALUES (6, 2, 'С��', 'M', 55);
INSERT INTO students (id, class_id, name, gender, score) VALUES (7, 2, 'С��', 'M', 85);
INSERT INTO students (id, class_id, name, gender, score) VALUES (8, 3, 'С��', 'F', 91);
INSERT INTO students (id, class_id, name, gender, score) VALUES (9, 3, 'С��', 'M', 89);
INSERT INTO students (id, class_id, name, gender, score) VALUES (10, 3, 'С��', 'F', 85);

-- OK:
SELECT 'ok' as 'result:';
