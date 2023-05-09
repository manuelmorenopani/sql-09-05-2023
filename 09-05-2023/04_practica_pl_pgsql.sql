-- EJERCICIOS
/*

1 - Escriba un bloque de codigo PL/pgSQL que reciba una nota como parametro
    y notifique en la consola de mensaje las letras A,B,C,D,E o F segun el valor de la nota
*/
DO $$
declare num int = 5;
begin 
IF num >= 90 THEN
RAISE NOTICE 'La nota es: A';
ELSIF num >= 8 AND num < 9 THEN
RAISE NOTICE 'La nota es: B';
ELSIF num >= 7 AND num < 8 THEN
RAISE NOTICE 'La nota es: C';
ELSIF num >= 6 AND num < 7 THEN
RAISE NOTICE 'La nota es: D';
ELSIF num >= 5 AND num < 6 THEN
RAISE NOTICE 'La nota es: E';
ELSE
RAISE NOTICE 'La nota es: F';
END IF;
END $$ language 'plpgsql';


/*
2 - Escriba un bloque de codigo PL/pgSQL que reciba un numero como parametro
    y muestre la tabla de multiplicar de ese numero.
*/
DO $$
declare num int = 5;
declare i integer;
declare multiplicar integer;
begin 
FOR i IN 1..10 LOOP
		multiplicar:=num*i;
        RAISE NOTICE '%' ,multiplicar;		
    END LOOP;
END $$ language 'plpgsql';

/*
3 - Escriba una funcion PL/pgSQL que convierta de dolares a moneda nacional.
    La funcion debe recibir dos parametros, cantidad de dolares y tasa de cambio.
    Al final debe retornar el monto convertido a moneda nacional.
*/
CREATE OR REPLACE FUNCTION convertira(dollares NUMERIC, tasa numeric )
RETURNS NUMERIC AS $$
BEGIN
    RETURN dollares * tasa;
END;
$$ LANGUAGE plpgsql;

select convertira(5 , 0.91)

/*

4 - Escriba una funcion PL/pgSQL que reciba como parametro el monto de un prestamo,
    su duracion en meses y la tasa de interes, retornando el monto de la cuota a pagar.
    Aplicar el metodo de amortizacion frances.

*/
DO $$
 DECLARE inicial numeric:=5000;
 duracion numeric:=12;
 tasa numeric:=0.05;
 cuota numeric;
 mensual numeric:= tasa_/12;
 factor numeric:= (1+ mensual)^duracion;

BEGIN
cuota:= (inicial * mensual * factor) / (factor -1);
RAISE NOTICE 'cantidad mensual: %', cuota;
END $$ LANGUAGE plpgsql;