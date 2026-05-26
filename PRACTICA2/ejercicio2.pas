Program ejercicio2;

Const
    VALOR_ALTO = 9999;

type
    producto = record
        cod: integer;
        nombre: string[30];
        precio: real;
        stockActual: integer;
        stockMinimo: integer;
    end;

    venta = record
        cod: integer;
        cantidad: integer;
    end;

    archivoM = file of producto;
    archivoD = file of venta;

procedure leer(var aD: archivoD; var v:venta);
begin
    if not eof(aD) then
        read(aD, v)
    else
        v.cod:= VALOR_ALTO;
end;

procedure actualizarMaestro(var aM: archivoM; var aD: archivoD);
var
    p: producto;
    v: venta;
    codActual: integer;
    total: integer;
begin
    writeln('----ACTUALIZACION DEL ARCHIVO MAESTRO');
    reset(aM);
    reset(aD);

    leer(aD, v);

    while(v.cod <> VALOR_ALTO) do begin
        read(aM, p);

        while(v.cod <> p.cod) do
            read(aM, p);

        while(v.cod = p.cod) do begin
            p.stockActual:= p.stockActual - v.cantidad;
            leer(aD, v);
        end;

        seek(aM, filepos(aM) - 1);
        write(aM, p);
    end;
    
    close(aM);
    close(aD);
    writeln('------ARCHIVO ACTUALIZADO CON EXITO------');
end;

procedure crearTxt(var aM: archivoM);
var
    txt: text;
    p: producto;
begin
    assign(txt, 'stock_minimo.txt');
    rewrite(txt);
    reset(aM);

    while not eof(aM) do begin
        read(aM, p);
        if(p.stockActual < p.stockMinimo)then begin
            writeln(txt, p.cod, ' ', p.precio, ' ', p.stockMinimo, ' ', p.stockActual);
            writeln(txt, p.nombre);
        end;
    end;

    close(aM);
    close(txt);

    writeln('Archivo stock_minimo.txt creado con exito');
end;

Var
    maestro: archivoM;
    detalle: archivoD;

Begin
   assign(maestro, 'maestro.dat');
   assign(detalle, 'detalle.dat');

    actualizarMaestro(maestro, detalle);
    crearTxt(maestro);
end.