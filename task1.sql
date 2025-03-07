create schema if not exists test_db;

create table if not exists test_db.address(
    id bigserial primary key,
    postal_code varchar(50) not null,
    city varchar(50) not null,
    street varchar(50) not null
);

create table if not exists test_db.profile(
    id bigserial primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    phone_number varchar(50) not null,
    birth_date timestamp  not null,

    address_id bigint references test_db.address(id) on delete cascade on update cascade
);

create table if not exists test_db.users(
    id bigserial primary key,
    login varchar(50) unique not null,
    password varchar(50) not null,

    profile_id bigint references test_db.profile(id) on delete cascade on update cascade
);

create table if not exists test_db.product(
    id bigserial primary key,
    title varchar(50) not null,
    price decimal(10,2) not null,
    count int not null
);

create table if not exists test_db.orders(
    id bigserial primary key,

    user_id bigint references test_db.users(id) on delete cascade on update cascade,
    product_id bigint references test_db.product(id) on delete cascade on update cascade,

    date_order timestamp not null,
    action varchar(50),


);

create table if not exists test_db.orders_product(
    product_id bigint references test_db.product(id) on delete cascade on update cascade unique,
    order_id bigint references test_db.orders(id) on delete cascade on update cascade unique,
    price_order decimal(10,2),

    primary key (product_id, order_id),
);