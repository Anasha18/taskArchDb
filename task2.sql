create schema if not exists test_db_task_2

create table if not exists test_db_task_2.address(
    id bigserial primary key,
    postal_code varchar(50) unique not null,
    city varchar(50) not null
);

create table if not exists test_db_task_2.profiles_students(
    id bigserial primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    phone_number varchar(50) unique not null,
    date_birth timestamp not null,

    address_id bigserial references test_db_task_2.address (id) on delete cascade on update cascade
);

create table if not exists test_db_task_2.students(
    id bigserial primary key,
    email varchar(50) unique not null,
    password varchar(50) not null,

    profile_id bigint references test_db_task_2.profiles_students(id) on delete cascade on update cascade
);

create table if not exists test_db_task_2.profiles_teachers(
id bigserial primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
phone_number varchar(50) unique not null,
date_birth timestamp not null,
work_exp int not null,

address_id bigint references test_db_task_2.address(id) on delete cascade on update cascade
);

create table if not exists test_db_task_2.teachers(
    id bigserial primary key,
    email varchar(50) unique not null,
    password varchar(50) not null,

    profile_teacher bigint references test_db_task_2.profiles_teachers(id) on delete cascade on update cascade
);

create table if not exists test_db_task_2.courses(
    id bigserial primary key,
    title varchar(50) not null,
    description text not null,
    price decimal(10,2) not null,
    duration timestamp
);

create table if not exists test_db_task_2.teaching_courses(
    teacher_id bigserial references test_db_task_2.teachers(id) on delete cascade on update cascade,
    course_id bigserial references test_db_task_2.courses(id) on delete cascade on update cascade,
    duration timestamp,

    primary key (teacher_id, course_id)
);

create table if not exists test_db_task_2.entries_courses(
    student_id bigserial references test_db_task_2.students(id) on delete cascade on update cascade,
    course_id bigserial references test_db_task_2.courses(id) on delete cascade on update cascade,
    date_entry timestamp,

    primary key (student_id, course_id)
);

create table if not exists test_db_task_2.courses_prerequisites(
    course_child_id bigserial references test_db_task_2.courses(id) on delete cascade on update cascade,
    course_parent_id bigserial references test_db_task_2.courses (id) on delete cascade on update cascade,

    primary key (course_child_id, course_parent_id)
)
