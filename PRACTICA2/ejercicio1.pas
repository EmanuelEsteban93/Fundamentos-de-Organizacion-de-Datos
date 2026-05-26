Program ejercicio1;

const 
    VALOR_ALTO = 9999;

type
    empleado = record
        cod: integer;
        nombre: string[50];
        comision: real;
    end;

    archivo = file of empleado;

procedure leer(var a: archivo; var e: empleado);
begin
    if not eof(a) then
        read(a, e)
    else
        e.cod:= VALOR_ALTO;
end;

procedure archivoFinal(var a1: archivo; var a2: archivo);
var
    e: empleado;
    e2: empleado;
    codActual: integer;
    comisionTotal: real;
    nombreActual:string[50];
begin
    reset(a1);
    rewrite(a2);

    leer(a1, e);
    while (e.cod <> VALOR_ALTO) do begin
        nombreActual:= e.nombre;
        codActual:= e.cod;
        comisionTotal:= 0;

        while (e.cod = codActual) do begin
            comisionTotal:= comisionTotal + e.comision;
            leer(a1, e);
        end;

        e2.nombre:= nombreActual;
        e2.cod:= codActual;
        e2.comision:= comisionTotal;
        write(a2, e2);
    end;

    close(a1);
    close(a2);
end;


var
    a1: archivo;
    a2: archivo;

begin
    assign(a1, 'archivo1.dat');
    assign(a2, 'archivo2.dat');    
    writeln('----------Bienvenido----------');
    archivoFinal(a1, a2);
    writeln('Pulse ENTER para terminar el programa...');
    readln();

end.