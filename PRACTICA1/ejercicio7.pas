Program ejercicio7;

Type
    novela = record
        codigo: integer;
        precio: real;
        genero: string[20];
        nombre: string[50];
    end;

    archivo = file of novela;

procedure nombrarArchivo(var n: archivo);
var
    nombre: string;
begin
    writeln('Ingrese el nombre del archivo para comenzar:');
    readln(nombre);
    assign(n, nombre + '.dat');
end;

procedure cargarTxt(var n: archivo);
var
    nov: novela;
    txt: text;
begin
    assign(txt, 'novelas.txt');
    reset(txt);
    rewrite(n);
    while not eof(txt) do begin
        readln(txt, nov.codigo, nov.precio, nov.genero);
        readln(txt, nov.nombre);
        write(n, nov);
    end;
    close(n);
    close(txt);
end;

procedure agregarNovela(var n: archivo);
var
    nov: novela;
begin
    writeln('Ingresando Nueva Novela:');
    write('CODIGO: ');
    readln(nov.codigo);
    write('PRECIO: ');
    readln(nov.precio);
    write('GENERO: ');
    readln(nov.genero);
    write('TITULO: ');
    readln(nov.nombre);

    reset(n);
    seek(n, filesize(n));
    write(n, nov);
    close(n);
    writeln('Novela agregada correctamente.');
    writeln('Pulse Enter para volver.');
    readln();
end;

procedure modificarNovela(var n: archivo);
var
    nov: novela;
    codigo: integer;
    existe: boolean;
begin
    existe:= false;
    write('Ingrese el codigo de la novela:');
    readln(codigo);
    reset(n);
    while not eof(n) and (existe = false)do begin
        read(n, nov);
        if(nov.codigo = codigo) then begin
            existe:= true;
            writeln('Novela Encontrada');
            writeln('Codigo: ', codigo);
            write('Precio: ');
            readln(nov.precio);
            write('Genero: ');
            readln(nov.genero);
            write('Titulo: ');
            readln(nov.nombre);
            writeln('Actualizando...');

            seek(n, filepos(n) - 1);
            write(n, nov);
            writeln('La novela ha sido actualizada correctamente.');
        end;
    end;
    close(n);
    if(existe = false) then
        writeln('No se encontro.');
    writeln('Pulse Enter para volver...');
    readln();
end;

procedure actualizarArchivo(var n: archivo);
var
    nov: novela;
    opcion: integer;
begin
    repeat 
        writeln('-----MENU PRINCIPAL-----');
        writeln('Seleccione una opcion:');
        writeln('1. Agregar una nueva novela al archivo.');
        writeln('2. Modificar novela existente');
        writeln('0. Salir.');
        readln(opcion);

        case opcion of
            1: agregarNovela(n);
            2: modificarNovela(n);
            0: begin
                writeln('Pulse ENTER para salir.');
                readln();
            end
            else
                writeln('Opcion Incorrecta.');
        end;


    until(opcion = 0); 
end;


Var
    n: archivo;
    op: integer;
Begin
    nombrarArchivo(n);
    writeln('Desea cargar un archivo de texto con la informacion?');
    writeln('1. Si');
    writeln('2. No');
    readln(op);

    if(op = 1) then
        cargarTxt(n);  
    actualizarArchivo(n);
end.