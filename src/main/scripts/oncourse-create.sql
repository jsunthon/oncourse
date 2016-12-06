-- suppress unnecessary messages when running the script.
set client_min_messages=WARNING;

-- start auto-generated ids from 1000000 so it's safe to use ids less than
-- that for pre-created records. 
create sequence hibernate_sequence minvalue 1000000;

----------------------------------------
-- courses, departments, and programs --
----------------------------------------

create table courses (
    id          bigint primary key,
    code        varchar(255) not null unique,
    name        varchar(255),
    units       integer not null default 3,
    obsolete    boolean not null default 'f'
);

create table departments (
    id      bigint primary key,
    name    varchar(255),
    deleted boolean not null default 'f'
);

create table programs (
    id              bigint primary key,
    department_id   bigint references departments(id),
    name            varchar(255) not null,
    description     varchar(8000)
);

create table program_blocks (
    id              bigint primary key,
    program_id      bigint references programs(id),
    name            varchar(255),
    description     varchar(8000),
    required_units  integer not null default 0,
    block_index     integer
);

create table program_block_courses (
    program_block_id    bigint not null references program_blocks(id),
    course_id           bigint not null references courses(id)
);

---------------------
-- users and roles --
---------------------

create table users (
    id          bigint primary key,
    username    varchar(255) not null unique,
    password    varchar(255) not null,
    email       varchar(255) not null unique,
    cin         varchar(255) not null unique,
    first_name  varchar(255),
    last_name   varchar(255),
    program_id  bigint references programs(id),
    enabled     boolean not null default 't'
);

create table authorities (
    user_id bigint not null references users(id),
    role    varchar(255)
);

------------------------------
-- grades and grade records --
------------------------------

create table grades (
    id          bigint primary key,
    symbol      varchar(255) not null unique,
    value       double precision,
    description varchar(8000)
);

insert into grades (id, symbol, value, description) values
    (2000, 'A', 4.0, 'Superior Attainment of Course Objectives');
insert into grades (id, symbol, value, description) values
    (2002, 'A-', 3.7, 'Outstanding Attainment of Course Objectives');
insert into grades (id, symbol, value, description) values
    (2004, 'B+', 3.3, 'Very Good Attainment of Course Objectives');
insert into grades (id, symbol, value, description) values
    (2006, 'B', 3.0, 'Good Attainment of Course Objectives');
insert into grades (id, symbol, value, description) values
    (2008, 'B-', 2.7, 'Fairly Good Attainment of Course  Objectives');
insert into grades (id, symbol, value, description) values
    (2010, 'C+', 2.3, 'Above Average Attainment of Course Objectives');
insert into grades (id, symbol, value, description) values
    (2012, 'C', 2.0, 'Average Attainment of Course Objectives');
insert into grades (id, symbol, value, description) values
    (2014, 'C-', 1.7, 'Below Average Attainment of Course Objectives');
insert into grades (id, symbol, value, description) values
    (2016, 'D+', 1.3, 'Weak Attainment of Course Objectives');
insert into grades (id, symbol, value, description) values
    (2018, 'D', 1.0, 'Poor Attainment of Course Objectives');
insert into grades (id, symbol, value, description) values
    (2020, 'D-', 0.7, 'Barely Passing Attainment of Course Objectives');
insert into grades (id, symbol, value, description) values
    (2022, 'F', 0.0, 'Non-Attainment of Course Objectives');
insert into grades (id, symbol, description) values
    (2024, 'CR', 'Credit');
insert into grades (id, symbol, description) values
    (2026, 'NC', 'No Credit');
insert into grades (id, symbol, description) values
    (2028, 'RP', 'Report in Progress');
insert into grades (id, symbol, description) values
    (2030, 'RD', 'Report Delayed');
insert into grades (id, symbol, description) values
    (2032, 'I', 'Incomplete  Authorized');
insert into grades (id, symbol, value, description) values
    (2034, 'IC', 0.0, 'Incompleted Charged');
insert into grades (id, symbol, description) values
    (2036, 'W', 'Withdraw');
insert into grades (id, symbol, value, description) values
    (2038, 'WU', 0.0, 'Withdraw Unauthorized');

create table grade_records (
    id          bigint primary key,
    student_id  bigint references users(id),
    term        integer not null,
    course_id   bigint references courses(id),
    grade_id    bigint references grades(id)
);
