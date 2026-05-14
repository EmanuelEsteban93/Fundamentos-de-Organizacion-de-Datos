Program ejercicio1;

type
    entero = file of integer;
var
    nombre_fisico: string;
    num: integer;
    archivo_enteros: entero;
begin
    writeln('Ingrese el nombre del archivo: ');
    read(nombre_fisico);

    assign(archivo_enteros, nombre_fisico + '.dat');
    rewrite(archivo_enteros);
    writeln('Ingrese numeros enteros(para salir ingrese el numero 30000)');
    read(num);

    while(num <> 30000) do begin
        write(archivo_enteros, num);
        writeln('Ingrese numeros enteros(para salir ingrese el numero 30000)');
        read(num);
    end;

    close(archivo_enteros);
    writeln('Archivo guardado correctamente. Presiona Enter para salir.');
    readln;
end.