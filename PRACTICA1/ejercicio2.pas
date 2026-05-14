Program ejercicio2;

type
    entero = file of integer;
var
    archivo : entero;
    nombre: string;
    num: integer;
    suma: integer;
    prom: real;
    menorA1500: integer;

Begin
    suma:= 0;
    prom:= 0;
    menorA1500:= 0;
    writeln('Ingrese el nombre del archivo creado en el ejercicio 1: ');
    readln(nombre);
    assign(archivo, nombre + '.dat');
    reset(archivo);
    writeln('------Contenido del archivo-------');
    while not eof(archivo) do begin
        read(archivo, num);
        if(num < 1500) then
            menorA1500:= menorA1500 + 1;
        prom:= prom + num;
        suma:= suma + 1;
        writeln(num);
    end;
    prom:= prom / suma;
    writeln('PROMEDIO: ', prom);
    writeln('La cantidad de numeros MENORES a 1500 fue: ', menorA1500);
    close(archivo);
    readln;

end.