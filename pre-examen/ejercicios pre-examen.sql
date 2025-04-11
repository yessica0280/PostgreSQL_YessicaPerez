create table users(
	id varchar(10) primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email varchar(50) not null,
	last_connection inet not null,
	website varchar(150) not null
);

create table products(
	id serial primary key,
	name varchar(50) not null,
	description text not null,
	stock numeric(10, 2) not null,
	price numeric (10, 2) not null,
	stockmin smallint default 0,
	stockmax smallint default 0
);

create table orders(
	id serial primary key,
	orderdate date not null,
	user_id varchar(10) not null
);

create table order_details(
	id serial primary key,
	order_id integer not null,
	product_id integer not null,
	quantity smallint not null,
	price numeric (10, 2) not null
);

create view stock_product as
select sum(stock_price) as stock_price, sum(stock) as stock, name from full_order_info group by name;
select * from stock_product;

create view stock_products as 
select sum(stock_price * stock) as stock_price, name from full_order_info group by name;
select * from stock_products where name = 'Webcam';


create materialized view stock_avg as
select sum(stock_price) as stock_price, sum(stock) as stock, name from full_order_info group by name;
select * from stock_avg;
refresh materialized view stock_avg;

alter table orders add constraint fk_users foreign key(user_id) references users(id);
alter table order_details add constraint fk_order foreign key(order_id) references orders(id);
alter table order_details add constraint fk_product foreign key(product_id) references products(id);
-- alter table order_details drop constraint fk_product;

select users.id, users.first_name, orders.orderdate from users 
left outer join orders on users.id = orders.user_id where orders.id is null;

select users.id, users.first_name, orders.id, od.product_id, od.quantity, od.price, p.name 
from users 
right join orders on users.id = orders.user_id 
left join order_details od on orders.id = od.order_id
left join products p on od.product_id = p.id;

select users.id, users.first_name, orders.id, orders.orderdate from users, orders
where users.id <> orders.user_id;

create view order_detail as
select users.id as user_id, users.first_name, orders.id as order_id, od.product_id, od.quantity, od.price, p.name 
from users 
right join orders on users.id = orders.user_id 
left join order_details od on orders.id = od.order_id
left join products p on od.product_id = p.id;

create or replace procedure total_amount(p_id_user varchar(20))
language plpgsql
as $$
declare
	total numeric;
begin
	select sum(quantity::numeric * price::numeric)
	into total
	from order_detail
	where user_id = p_id_user;

	raise notice 'El total de $ gastado % es %', pe_id_user, total;
end;
$$;
call total_amount('00005');

INSERT INTO users (id, first_name, last_name, email, last_connection, website) 
VALUES ('00001', 'Pamela', 'Harvey', 'pamela.harvey@icloud.com', '130.169.26.40', 'https://www.cummings-myers.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00002', 'Zachary', 'Lopez', 'zachary.lopez@icloud.com', '71.36.0.117', 'https://www.jimenez.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00003', 'Heather', 'Tucker', 'heather.tucker@hotmail.com', '149.255.250.172', 'https://jones.net/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00004', 'Amanda', 'Khan', 'amanda.khan@icloud.com', '131.155.80.238', 'http://hebert.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00005', 'Tammy', 'Cordova', 'tammy.cordova@yahoo.com', '114.150.104.42', 'http://www.horton.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00006', 'Steven', 'Carr', 'steven.carr@yahoo.com', '68.70.110.86', 'https://www.nelson.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00007', 'Jon', 'Harris', 'jon.harris@gmail.com', '51.171.236.174', 'https://jennings-johnson.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00008', 'Jonathan', 'Rosales', 'jonathan.rosales@yahoo.com', '192.250.4.45', 'http://www.banks.info/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00009', 'Juan', 'Taylor', 'juan.taylor@hotmail.com', '108.144.245.239', 'https://carrillo-garrison.info/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00010', 'Cynthia', 'Gomez', 'cynthia.gomez@gmail.com', '166.180.144.101', 'https://www.bautista.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00011', 'Jeremy', 'Monroe', 'jeremy.monroe@outlook.com', '217.91.149.219', 'https://gardner.info/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00012', 'Justin', 'Brady', 'justin.brady@yahoo.com', '128.228.157.13', 'https://white.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00013', 'Kimberly', 'Jones', 'kimberly.jones@outlook.com', '203.198.239.224', 'http://www.bruce.info/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00014', 'Cindy', 'Rhodes', 'cindy.rhodes@yahoo.com', '222.134.190.254', 'https://www.romero.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00015', 'Christopher', 'Johns', 'christopher.johns@outlook.com', '172.48.250.134', 'https://www.keller.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00016', 'Karen', 'Taylor', 'karen.taylor@yahoo.com', '75.32.21.153', 'http://www.carr-gardner.net/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00017', 'Donna', 'Kidd', 'donna.kidd@icloud.com', '216.170.193.57', 'http://www.gomez.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00018', 'Samantha', 'Mcclure', 'samantha.mcclure@hotmail.com', '81.236.20.151', 'http://www.jones.org/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00019', 'Katherine', 'Richardson', 'katherine.richardson@protonmail.com', '28.123.28.50', 'https://morgan.org/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00020', 'Jasmin', 'Williams', 'jasmin.williams@protonmail.com', '87.83.115.178', 'https://cummings.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00021', 'Hector', 'West', 'hector.west@gmail.com', '178.92.208.234', 'http://randall-martin.biz/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00022', 'Daniel', 'Foster', 'daniel.foster@gmail.com', '132.55.175.77', 'http://www.fuentes-lambert.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00023', 'James', 'Patton', 'james.patton@hotmail.com', '222.174.26.127', 'https://www.bryant.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00024', 'Nicole', 'Martinez', 'nicole.martinez@yahoo.com', '46.218.182.124', 'https://www.zimmerman.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00025', 'Tony', 'Murphy', 'tony.murphy@protonmail.com', '9.16.26.180', 'http://walker.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00026', 'Danielle', 'Smith', 'danielle.smith@gmail.com', '196.95.185.175', 'http://shah.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00027', 'Joseph', 'Cook', 'joseph.cook@yahoo.com', '207.142.24.181', 'https://www.jones.info/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00028', 'Kristina', 'White', 'kristina.white@outlook.com', '63.166.114.85', 'http://www.hurst-campbell.com/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00029', 'Mark', 'Wilson', 'mark.wilson@outlook.com', '14.149.117.19', 'https://www.anderson.info/');
INSERT INTO users ("id", "first_name", "last_name", "email", "last_connection", "website") 
VALUES ('00030', 'Wanda', 'Robinson', 'wanda.robinson@hotmail.com', '209.210.46.192', 'http://morris.com/');

INSERT INTO products (name, description, stock, price, stockmin, stockmax) 
VALUES ('Laptop', 'Lot old magazine learn close art physical.', 97, 1084.85, 10, 98);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Smartphone', 'Unit economy bad including recent three seem offer continue rest.', 74, 545.58, 9, 172);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Tablet', 'Attorney ground hair senior customer exist.', 31, 1309.25, 1, 86);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Monitor', 'Trial per movement fast day help and hold.', 40, 234.68, 6, 111);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Keyboard', 'Doctor hear lay white ready color action option tough past she.', 99, 1052.35, 87, 199);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Mouse', 'West end year he quickly life with left list hospital describe unit possible.', 32, 1208.06, 13, 54);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Printer', 'Before test for information teach least go wear.', 74, 884.87, 42, 103);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Headphones', 'First political pattern anything news be machine while.', 44, 56.86, 21, 119);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Webcam', 'Standard second believe prove physical end future again both account century.', 32, 377.28, 8, 62);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('USB Drive', 'Rate trouble rich prepare visit total sell spring save here pick manager.', 73, 359.74, 33, 124);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('External HDD', 'Notice true record policy theory above claim cut.', 31, 115.21, 24, 67);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Router', 'Help reality send most rock tax character mouth.', 69, 1410.72, 59, 112);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Smartwatch', 'Buy task kitchen which firm every wide build book.', 35, 933.21, 28, 135);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Speaker', 'Economic I involve move back debate type practice cup.', 79, 790.44, 58, 95);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Microphone', 'On others where body option voice chance true.', 33, 1418.06, 11, 109);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Projector', 'Ten cost small need situation window strategy service drop school.', 52, 1167.77, 6, 89);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Drone', 'Mind note politics news still order also reflect home.', 18, 1151.97, 5, 87);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Graphics Card', 'Call current once join term office read per main catch son.', 100, 484.15, 99, 107);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Motherboard', 'Large see beyond many lead eye school cause financial actually bring relationship everything.', 42, 322.49, 14, 61);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('RAM Module', 'Decide front the democratic between structure culture sea wrong.', 41, 464.58, 12, 54);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('SSD', 'Past accept manage program half care friend outside can public rule.', 69, 1167.34, 58, 135);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Power Supply', 'Door event thing herself capital strong within interview home.', 76, 337.75, 35, 110);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Cooling Fan', 'Life role stage decade office call board customer.', 19, 856.91, 12, 99);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Gaming Chair', 'Medical so job spend become current various less.', 56, 741.41, 50, 69);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Desk Lamp', 'Particularly include old miss song well.', 44, 385.24, 23, 71);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Surge Protector', 'Color Republican show above white agreement long.', 81, 644.79, 59, 179);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Ethernet Cable', 'Different successful street truth wind one few.', 47, 964.07, 28, 106);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('VR Headset', 'Above short accept responsibility personal if officer visit surface pass arrive skin.', 67, 135.91, 35, 124);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Bluetooth Adapter', 'Service fund road indicate language into huge including writer sort college.', 53, 107.56, 25, 133);
INSERT INTO products ("name", "description", "stock", "price", "stockmin", "stockmax") 
VALUES ('Portable Charger', 'Reduce control improve laugh already at professional study by.', 27, 1079.04, 7, 59);

INSERT INTO orders (id, orderdate, user_id)
VALUES (1, '2025-02-16', '00005');
INSERT INTO orders ("id", "orderdate", "user_id")
VALUES (2, '2025-03-06', '00005');
INSERT INTO orders ("id", "orderdate", "user_id")
VALUES (3, '2025-03-25', '00005');
INSERT INTO orders ("id", "orderdate", "user_id")
VALUES (4, '2025-03-18', '00003');
INSERT INTO orders ("id", "orderdate", "user_id")
VALUES (5, '2025-03-10', '00001');
INSERT INTO orders ("id", "orderdate", "user_id")
VALUES (6, '2025-02-13', '00003');
INSERT INTO orders ("id", "orderdate", "user_id")
VALUES (7, '2025-02-11', '00006');
INSERT INTO orders ("id", "orderdate", "user_id")
VALUES (8, '2025-03-16', '00009');
INSERT INTO orders ("id", "orderdate", "user_id")
VALUES (9, '2025-02-27', '00002');
INSERT INTO orders ("id", "orderdate", "user_id")
VALUES (10, '2025-03-22', '00003');
INSERT INTO orders ("id", "orderdate", "user_id")
VALUES (11, '2025-02-17', '00010');
INSERT INTO orders ("id", "orderdate", "user_id")
VALUES (12, '2025-03-07', '00006');
INSERT INTO orders ("id", "orderdate", "user_id")
VALUES (13, '2025-03-31', '00005');
INSERT INTO orders ("id", "orderdate", "user_id")
VALUES (14, '2025-03-10', '00001');
INSERT INTO orders ("id", "orderdate", "user_id")
VALUES (15, '2025-03-19', '00008');

INSERT INTO order_details (id, order_id, product_id, quantity, price)
VALUES (1, 1, 9, 5, 544.2);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (2, 2, 10, 2, 428.26);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (3, 3, 2, 4, 250.73);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (4, 4, 1, 5, 811.79);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (5, 4, 10, 5, 428.26);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (6, 5, 4, 1, 1432.67);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (7, 5, 5, 1, 1146.23);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (8, 6, 6, 1, 322.04);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (9, 7, 4, 5, 1432.67);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (10, 8, 1, 1, 811.79);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (11, 9, 7, 1, 517.03);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (12, 9, 10, 5, 428.26);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (13, 10, 6, 4, 322.04);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (14, 11, 9, 2, 544.2);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (15, 11, 5, 3, 1146.23);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (16, 12, 10, 4, 428.26);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (17, 12, 8, 2, 560.26);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (18, 12, 4, 5, 1432.67);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (19, 13, 10, 5, 428.26);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (20, 14, 3, 3, 1329.51);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (21, 15, 9, 1, 544.2);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (22, 15, 2, 1, 250.73);
INSERT INTO order_details ("id", "order_id", "product_id", "quantity", "price")
VALUES (23, 15, 1, 1, 811.79);

INSERT INTO sales_audit (order_id, user_id, total_value, audit_date) 
VALUES
(1, 1, 250.75, '2025-04-10 10:00:00'),
(2, 2, 120.50, '2025-04-10 10:15:00'),
(3, 3, 300.00, '2025-04-10 10:30:00'),
(4, 4, 450.25, '2025-04-10 10:45:00'),
(5, 5, 189.99, '2025-04-10 11:00:00'),
(6, 6, 75.00, '2025-04-10 11:15:00'),
(7, 7, 500.50, '2025-04-10 11:30:00'),
(8, 8, 89.99, '2025-04-10 11:45:00'),
(9, 9, 350.75, '2025-04-10 12:00:00'),
(10, 10, 210.60, '2025-04-10 12:15:00');

INSERT INTO orders_update_log (order_id, old_user_id, new_user_id, old_order_date, new_order_date, changed_at)
VALUES
(1, 1, 2, '2025-04-01', '2025-04-02', '2025-04-10 12:00:00'),
(2, 3, 4, '2025-03-15', '2025-03-16', '2025-04-10 12:10:00'),
(3, 5, 6, '2025-02-20', '2025-02-21', '2025-04-10 12:20:00'),
(4, 7, 8, '2025-01-10', '2025-01-11', '2025-04-10 12:30:00'),
(5, 9, 10, '2025-03-25', '2025-03-26', '2025-04-10 12:40:00'),
(6, 11, 12, '2025-04-05', '2025-04-06', '2025-04-10 12:50:00'),
(7, 13, 14, '2025-02-14', '2025-02-15', '2025-04-10 13:00:00'),
(8, 15, 16, '2025-03-01', '2025-03-02', '2025-04-10 13:10:00'),
(9, 17, 18, '2025-04-08', '2025-04-09', '2025-04-10 13:20:00'),
(10, 19, 20, '2025-02-28', '2025-03-01', '2025-04-10 13:30:00');


-- Registrar automáticamente cada venta realizada en una tabla de auditoría, con la ayuda de un `TRIGGER`, un `FUNCTION`, una `VIEW` y una `MATERIALIZED VIEW`.

-- 1. Crea una tabla de auditoría
CREATE TABLE sales_audit (
  audit_id SERIAL PRIMARY KEY,
  order_id INT,
  user_id INT,
  total_value NUMERIC,
  audit_date TIMESTAMP DEFAULT NOW()
);

-- 2. Cree una función que se active al insertar una nueva orden teniendo presente la siguiente instrucción SQL y las sugerencias.
   CREATE OR REPLACE FUNCTION fn_register_audit()
   RETURNS TRIGGER AS $$
   DECLARE
     total NUMERIC;
   BEGIN
	   select sum(od.quantity * od.price)
	   into total from order_details od
	   where od.order_id = new.order_id;

	   insert into sales_audit(order_id, user_id, total_value, audit_date)
	   values(new.order_id, new.user_id, total, now());
     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

-- 3. Crea el `TRIGGER` asociado:
   CREATE TRIGGER trg_audit_sale
   AFTER INSERT ON orders
   FOR EACH ROW
   EXECUTE FUNCTION fn_register_audit();
   
select tgname, tgrelid::regclass, tgfoid::regprocedure
from pg_trigger where tgname = 'trg_audit_sale';

-- 4. Crea una `VIEW` que muestre el historial de ventas con información del usuario y total.
   -- Cree la vista teniendo presente la información de la tabla sales_audit 
   -- Datos sugeridos a mostrar -> audit_id, username, total_value, audit_date
create view sales_history as
select sa.audit_id,sa.total_value, sa.audit_date
from sales_audit sa inner join users u on sa.user_id::varchar = u.id
order by sa.audit_date desc;

-- 5. Crea una `MATERIALIZED VIEW` que resuma los ingresos diarios.
   -- Cree la vista MATERIALIZED teniendo presente la información de la tabla sales_audit 
   -- Datos sugeridos a mostrar -> sale_date(DATE de audit_date), daily_total(Suma de los valores de total)
   -- Ten presente el GROUP BY y si requieres actualizar la vista puedes usar
   -- REFRESH MATERIALIZED VIEW mi_nombre_de_materialized_view;
create materialized view daily_sales_summary as
select date(audit_date) as sale, sum(total_value) as daily
from sales_audit group by date(audit_date) order by sale;

-- Reto: Gestión de Stock y Ventas con Procedimiento
-- Propósito**: Automatizar el proceso de venta de productos mediante un `PROCEDURE` que reste el stock y registre la venta, apoyado con validaciones y consultas en una `VIEW`.
create or replace procedure process_sale(
	p_order_id int,
	p_product_id int,
	p_quantity int
)
language plpgsql
as $$ 
declare
	v_stock int;
	v_price numeric(10, 2);
begin
	select stock, price into v_stock, v_price from products where product_id = p_product_id;
	
if not found then
	raise exception 'producto con ID % no existe', p_product_id;
end if;
	
if v_stock < p_quantity then 
	raise exception 'stock insuficiente. Disponible: %, solicitado: %', v_stock, p_quantity;
end if;

insert into order_details(order_id, product_id, quantity, price)
values (p_order_id, p_product_id, p_quantity, v_price);

update products set stock = stock - p_quantity where product_id = p_product_id;

raise notice 'venta realizada con exito. Stock restante: %', v_stock - p_quantity;
end;
$$;
call process_sale(1, 11, 3);

create view product_sales_summary as
select p.id, p.name, sum(od.quantity) as total_sold, sum(od.quantity * od.price) as total
from products p left join order_details od on p.id = od.product_id
group by p.id, p.name order by total desc;

-- 1. Crea un procedimiento llamado `prc_register_sale` que permita recibir los valores de `user_id`, `product_id` y `quantity`:
   CREATE OR REPLACE PROCEDURE prc_register_sale(
     p_user_id INT,
     p_product_id INT,
     p_quantity INT
   )
   LANGUAGE plpgsql
   AS $$
   DECLARE
     stock_actual int;
	 precio_unitario numeric(10, 2);
	 nuevo_order_id int;
   BEGIN
     SELECT stock, price INTO stock_actual, precio_unitario FROM products WHERE product_id = p_product_id;

     IF stock_actual < p_quantity THEN
       RAISE EXCEPTION 'Stock insuficiente: % ', stock_actual, p_quantity;
     END IF;

	 insert into orders(user_id, order_date) values (p_user_id, current_date)
	 returning order_id into nuevo_order_id;

	 insert into order_details (order_id, product_id, quantity, price)
	 values (nuevo_order_id, p_product_id, p_quantity, precio_unitario);

	 update products set stock = stock - p.quantity 
	 where product_id = p_product_id;

     raise notice 'venta registrada: %, restante: %', nuevo_order_id, stock_actual - p_quantity;
   END;
   $$;
call prc_registrar_sale(1, 12, 2);  -- falta, no funciona bien.


-- 2. Crea una `VIEW` llamada `vw_products_low_stock` para mostrar productos con stock menor a 10:
CREATE VIEW vw_products_low_stock AS
SELECT id, name, stock FROM products WHERE stock < 10;

-- 3. Llama al procedimiento y observa la magia:
   CALL prc_register_sale(1, 3, 2); -- falta, no funciona bien.

-- Reto: Control de Modificaciones en Pedidos

-- Propósito:** Registrar cambios realizados sobre los pedidos (`orders`) mediante funciones, procedimientos y triggers, incluyendo auditoría de actualizaciones y bloqueos de eliminación.

-- Tabla de auditoría de actualizaciones
  CREATE TABLE orders_update_log (
    log_id SERIAL PRIMARY KEY,
    order_id INT,
    old_user_id INT,
    new_user_id INT,
    old_order_date DATE,
    new_order_date DATE,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );
  
-- Crea una `FUNCTION` para registrar actualizaciones de la tabla `orders`  teniendo presente la siguiente instrucción` SQL` y las sugerencias.
  CREATE OR REPLACE FUNCTION fn_log_order_update()
  RETURNS TRIGGER AS $$
  BEGIN
  	insert into orders_update_log (order_id, old_user_id, new_user_id, old_orderdate, new_orderdate)
	values (old.id, old.user_id, new.user_id, old.orderdate, new.orderdate);
    RETURN NEW;
  END;
  $$ LANGUAGE plpgsql;

-- Crea un ` TRIGGER` para registrar actualizaciones teniendo presente la siguiente instrucción `SQL` y las sugerencias.
  CREATE TRIGGER trg_log_order_update
  AFTER UPDATE ON orders
  FOR EACH ROW
  when (old.* is distinct from new.*)
  EXECUTE FUNCTION fn_log_order_update();

-- Crea una `FUNCTION` para evitar eliminación si el pedido ya tiene detalles teniendo presente la siguiente instrucción `SQL` y las sugerencias.
  CREATE OR REPLACE FUNCTION fn_prevent_order_delete()
  RETURNS TRIGGER AS $$
  DECLARE
    exists_detail BOOLEAN;
  BEGIN
  	select exists (select 1 from order_details where order_id = old.id) into exists_detail;
  
    IF exists_detail THEN
      raise exception 'no se pudo eliminar el id % cuenta condetalles asociados', old.id;
    END IF;
  
    RETURN OLD;
  END;
  $$ LANGUAGE plpgsql;

-- Crea un `TRIGGER` para bloquear eliminación teniendo presente la siguiente instrucción `SQL` y las sugerencias.
  CREATE TRIGGER trg_prevent_order_delete
  before delete on orders
  FOR EACH ROW
  execute function fn_prevent_order_delete();
  
-- Crea dos `PROCEDURE` para actualizar pedidos de forma controlada para cuando se cambie de `user_id` y de `order_date` de la tabla `orders` .
  CREATE OR REPLACE PROCEDURE prc_update_order_user(
    p_order_id INT,
    p_new_user_id varchar(10)
  )
  LANGUAGE plpgsql
  AS $$
  BEGIN
  if not exists (select 1 from orders where id = p_order_id) then
  raise exception 'la orden con id % no existe', p_order_id;
  end if;
  
    UPDATE orders set user_id = p_new_user_id where id = p_order_id;

	raise notice 'orden % actualizado usuario nuevo: %', p_order_id, p_new_user_id;
  END;
  $$;
  
  CREATE OR REPLACE PROCEDURE prc_update_order_user(
    p_order_date DATE,
    p_order_id INT
  )
  LANGUAGE plpgsql
  AS $$
  BEGIN
  if not exists (select 1 from orders where id = p_order_id) then
  	raise exception 'la orden con el id % no existe', p_order_id;
  end if;
  
    UPDATE orders set orderdate = p_order_date where id = p_order_id;

	raise notice 'orden % actualizada %', p_order_id, p_order_date;
  END;
  $$;