create schema if not exists task3db_arch;

create table if not exists task3db_arch.profiles_user
(
    id         bigserial primary key,
    first_name varchar(50) not null,
    last_name  varchar(50) not null,
    date_birth timestamp   not null
);

create table if not exists task3db_arch.users
(
    id         bigserial primary key,
    email      varchar(50) unique not null,
    password   varchar(50),

    profile_id bigint references task3db_arch.profiles_user (id) on delete cascade on update cascade
);

create table if not exists task3db_arch.tasks
(
    id          bigserial primary key,
    title       varchar(50) not null,
    description text        not null,
    status      varchar(50) not null,
    priority    varchar(50) not null
);

create table if not exists task3db_arch.projects
(
    id          bigserial primary key,
    title       varchar(50) not null,
    description text        not null,

    task_id     bigint references task3db_arch.tasks (id) on delete cascade on update cascade
);

create table if not exists task3db_arch.users_projects
(
    user_id    bigint references task3db_arch.users (id) on delete cascade on update cascade,
    project_id bigint references task3db_arch.projects (id) on delete cascade on update cascade,

    start_date timestamp,
    role       varchar(50),

    primary key (user_id, project_id)
);

create table if not exists task3db_arch.comments
(
    id          bigserial primary key,
    description text,

    task_id     bigint references task3db_arch.tasks (id) on delete cascade on update cascade
);

create table if not exists task3db_arch.files
(
    id      bigserial primary key,
    title   varchar(50) not null,
    weight  bigint,

    task_id bigint references task3db_arch.tasks (id) on delete cascade on update cascade
);

create table if not exists task3db_arch.tags
(
    id    bigserial primary key,
    title varchar(50)
);

create table if not exists task3db_arch.tasks_tags
(
    task_id bigint references task3db_arch.tasks (id) on delete cascade on update cascade,

    tag_id bigint references task3db_arch.tags (id) on delete cascade on update cascade,

    primary key (task_id, tag_id)
);

create table if not exists task3db_arch.task_sequenses(
    child_task_id bigint references task3db_arch.tasks (id) on delete cascade on update cascade,

    parent_task_id bigint references task3db_arch.tasks (id) on delete cascade on update cascade,

    primary key (child_task_id, parent_task_id)
)

