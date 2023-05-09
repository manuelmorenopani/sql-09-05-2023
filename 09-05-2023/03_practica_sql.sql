--Subconsultas

-- Obtener los productos cuyo precio unitario sea mayor al precio promedio de la tabla de productos
SELECT * 
FROM public.products
WHERE unit_price > (SELECT AVG(unit_price) FROM public.products);
-- Obtener los productos cuya cantidad en stock sea menor al promedio de cantidad en stock de toda la tabla de productos.
SELECT * 
FROM public.products
WHERE units_in_stock < (SELECT AVG(units_in_stock) FROM public.products)
-- Obtener los productos cuya cantidad en Inventario (UnitsInStock) sea menor a la cantidad mínima del detalle de ordenes (Order Details)
SELECT public.products.* 
FROM public.products
WHERE units_in_stock < (SELECT MIN(quantity) FROM order_details)
--OBTENER LOS PRODUCTOS CUYA CATEGORIA SEA IGUAL A LAS CATEGORIAS DE LOS PRODUCTOS CON PROVEEDOR 1.
SELECT public.products.*
FROM public.products
WHERE category_id IN (SELECT category_id FROM public.products WHERE supplier_id = 1)
-- Subconsultas correlacionadas 

--Obtener el número de empleado y el apellido para aquellos empleados que tengan menos de 100 ordenes.
SELECT employee_id,last_name 
FROM employees e
where 100 >
(select COUNT(order_id) 
 from orders o 
 where e.employee_id = o.employee_id);
--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes
SELECT customer_id, company_name
FROM public.customers e
WHERE 20 >(
   select COUNT(order_id) 
 from orders o 
 where e.customer_id= o.customer_id
);
--Obtener el productoid, el nombre del producto, el proveedor de la tabla de productos para aquellos productos que se hayan vendido menos de 100 unidades (Consultarlo en la tabla de Orders details).
SELECT product_id, product_name,supplier_id
FROM public.products e
WHERE 100 >(
  SELECT COUNT(quantity)
  FROM public.order_details o
   where e.product_id= o.product_id
);
--Obtener los datos del empleado IDEmpleado y nombre completo De aquellos que tengan mas de 100 ordenes
SELECT employee_id,last_name 
FROM employees e
where 100 <
(select COUNT(order_id) 
 from orders o 
 where e.employee_id = o.employee_id);
--Obtener los datos de Producto ProductId, ProductName, UnitsinStock, UnitPrice (Tabla Products) de los productos que la sumatoria de la cantidad (Quantity) de orders details sea mayor a 450
SELECT product_id, product_name, units_in_stock, unit_price
FROM public.products
WHERE product_id IN (
  SELECT product_id
  FROM public.order_details
  GROUP BY product_id
  HAVING SUM(quantity) > 450
)
--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes.
SELECT customer_id, company_name
FROM public.customers e
WHERE 20 <(
   select COUNT(order_id) 
 from orders o 
 where e.customer_id= o.customer_id
);

--insert

--Insertar un registro en la tabla de Categorias, únicamente se quiere insertar la información del CategoryName y la descripción los Papelería y papelería escolar
INSERT INTO public.categories (category_id, category_name, description)
VALUES ('20','Papelería', 'papelería escolar');
select * from public.categories
--Dar de alta un producto con Productname, SupplierId, CategoryId, UnitPrice, UnitsInStock Como esta tabla tiene dos clave foraneas hay que ver los datos a dar de alta
INSERT INTO public.products (product_id,product_name,supplier_id,category_id,quantity_per_unit,unit_price,units_in_stock,units_on_order,reorder_level,discontinued)
VALUES ('100','Guayaba', '2', '1','10 boxes','23','30','0', '10', '1');
select * from public.products
--Dar de alta un empleado con LastName, FistName, Title, BrithDate
INSERT INTO public.employees (employee_id, last_name, first_name,title, birth_date)
VALUES ('20','Medina', 'Ruben', 'Sales Representative','1959-11-02');
select * from public.employees
--Dar de alta una orden, CustomerId, Employeeid, Orderdate, ShipVia Como esta tabla tiene dos clave foraneas hay que ver los datos a dar de alta

--Dar de alta un Order details, con todos los datos

--update

-- Cambiar el CategoryName a Verduras de la categoria 10
UPDATE public.categories
SET category_name = 'Verduras'
WHERE category_id = 10;
select * from public.categories
-- Actualizar los precios de la tabla de Productos para incrementarlos un 10%
UPDATE public.products
SET unit_price = unit_price * 1.1;
--ACTUALIZAR EL PRODUCTNAME DEL PRODUCTO 80 A ZANAHORIA ECOLOGICA
UPDATE public.products
SET  product_name = 'ZANAHORIA'
WHERE product_id = 80;
--ACTUALIZAR EL FIRSTNAME DEL EMPLOYEE 10 A ROSARIO 
UPDATE public.employees
SET  first_name = 'Rosario'
WHERE employee_id = 10;
--ACTUALIZAR EL ORDERS DETAILS DE LA 11079 PARA QUE SU CANTIDAD SEA 10
UPDATE public.order_details
SET  quantity = '10'
WHERE order_id = 11079;
--Delete

--diferencia entre delete y truncate
--BORRAR EL EMPLEADO 10
DELETE FROM public.employees
WHERE employee_id = 10;


