insert into user_entity (id, username, password, dni, nombre, email, tlf, avatar, roles, account_non_expired, account_non_locked, credentials_non_expired, enabled, created_at, last_password_change_at) values ('3e380d54-861c-4809-bb84-bd32bab42c2e', 'mrl26', '{bcrypt}oq2HCiJ7QR', '09124790Y', 'Mario Ruiz López', 'mario@mario.com', '676 384 054', 'https://robohash.org/mrl26', 'ADMIN', 'true', 'true', 'true', 'true', '2023-02-10 00:00:00', '2023-02-10 00:00:00');
insert into user_entity (id, username, password, dni, nombre, email, tlf, avatar, roles, account_non_expired, account_non_locked, credentials_non_expired, enabled, created_at, last_password_change_at) values ('17f920ca-57ac-4053-933c-7d5a6c9cd328', 'asp14', '{bcrypt}V31udFIE0K6C', '30376644T', 'Alejandro Santos Pacheco', 'ale@ale.com', '675 796 623', 'https://robohash.org/asp14', 'MEC', 'true', 'true', 'true', 'true', '2023-02-10 00:00:00', '2023-02-10 00:00:00');
insert into user_entity (id, username, password, dni, nombre, email, tlf, avatar, roles, account_non_expired, account_non_locked, credentials_non_expired, enabled, created_at, last_password_change_at) values ('d182a454-9998-4c82-a622-2d7bafc0379a', 'jjml4', '{bcrypt}V31udFIE0K6C', '52874103V', 'Jose Javier Moriña León', 'jj@jj.com', '675 796 623', 'https://robohash.org/jjml4', 'CLIENTE', 'true', 'true', 'true', 'true', '2023-02-10 00:00:00', '2023-02-10 00:00:00');

insert into cliente (user_entity_id, vehiculo, matricula) values ('d182a454-9998-4c82-a622-2d7bafc0379a', 'Fiat Punto', '2014GMD')
insert into mecanico (user_entity_id) values ('3e380d54-861c-4809-bb84-bd32bab42c2e')
insert into mecanico (user_entity_id) values ('17f920ca-57ac-4053-933c-7d5a6c9cd328')