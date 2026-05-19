Program ejercicio5y6;

type
    celular = record
        cod: integer;
        nombre: string[30];
        descripcion: string[100];
        marca: string[30];
        precio: real;
        stockMin: integer;
        stockDisp: integer;
    end;

    archivo = file of celular;

procedure importarCelulares(var c: archivo);
var
    txt: text;
    cel: celular;
begin
    assign(txt, 'celulares.txt');
    rewrite(c);
    reset(txt);

    while not eof(txt) do begin
        readln(txt, cel.cod, cel.precio, cel.marca);
        readln(txt, cel.stockDisp, cel.stockMin, cel.descripcion);
        readln(txt, cel.nombre);

        write(c, cel);
    end;
    close(c);
    close(txt);

    writeln('El archivo  ha sido credo correctamente.');
    writeln('Pulse Enter para terminar...');
    readln();
end;

procedure bajoStock(var c:archivo);
var
    cel: celular;
    hay: boolean;
begin
    hay:= false;
    reset(c);
    writeln('--------LISTADO DE BAJO STOCK-----------');
    while not eof(c) do begin
        read(c,cel);
        if(cel.stockDisp < cel.stockMin) then begin
            writeln('NOMBRE: ', cel.nombre, ' CODIGO: ', cel.cod, ' MARCA: ', cel.marca, 
            ' PRECIO:', cel.precio, ' S. MINIMO:', cel.stockMin, ' DISPONIBLE: ', cel.stockDisp, 
            ' DESCRIPCION: ', cel.descripcion);
            hay:= true;
        end;
    end;

    if(hay = false) then 
        writeln('No se encontraron productos con Bajo Stock.')
    else
        writeln('LISTA FINALIZADA.');

    close(c);

    writeln('Pulse Enter para terminar...');
    readln();
end;

procedure buscarDescripcion(var c: archivo);
var
    cel: celular;
    desc: string[100];
    encontrado: boolean;
begin
    encontrado:= false;
    writeln('Ingrese la descripcion o palabras que desea buscar:');
    readln(desc);
    writeln('Buscando...', ' " ', desc, ' " ...' );
    reset(c);
    while not eof(c) do begin
        read(c,cel);
        if (pos(desc, cel.descripcion) > 0) then begin
            writeln('NOMBRE: ', cel.nombre, ' CODIGO: ', cel.cod, ' MARCA: ', cel.marca, 
            ' PRECIO:', cel.precio, ' S. MINIMO:', cel.stockMin, ' DISPONIBLE: ', cel.stockDisp, 
            ' DESCRIPCION: ', cel.descripcion);
            encontrado:= true;
        end;
    end;
    if(encontrado = false) then
        writeln('Palabra/s no encontrada/s. ')
    else
        writeln('Busqueda finalizada con exito!');
    
    close(c);
    writeln('Presione Enter para salir...');
    readln();
end;

procedure exportarTxt(var c: archivo);
var
    cel: celular;
    txt: text;
    opcion: integer;
begin
    writeln('Desea descargar el archivo completo:');
    writeln('1. Si.');
    writeln('2. No');
    readln(opcion);

    if(opcion = 1) then begin
        assign(txt, 'celulares.txt');
        rewrite(txt);
        reset(c);

        while not eof(c) do begin
            read(c,cel);
            writeln(txt, cel.cod, ' ', cel.precio, ' ', cel.marca);
            writeln(txt, cel.stockDisp, ' ', cel.stockMin, ' ', cel.descripcion);
            writeln(txt, cel.nombre);
        end;
        close(c);
        close(txt);

        writeln('Archivo descargado con exito!.');
        writeln('Presione Enter para salir del programa.');
        readln();
    end
    else begin
        writeln('Presione Enter para salir del programa.');
        readln();
    end;
end;

procedure agregarCelulares( var c: archivo);
var
    cel: celular;
    num: integer;
begin
    writeln('Desea agregar un celular al archivo:');
    writeln('1. Si');
    writeln('2. No');
    readln(num);
    reset(c);
    while (num = 1) do begin

        seek(c, filesize(c));
        
        writeln('-------Agregando Celular------');
        writeln('CODIGO DE CELULAR: ', ' PRECIO: ', ' MARCA: ');
        readln(cel.cod, cel.precio, cel.marca);
        writeln('STOCK DISPONIBLE: ', ' STOCK MINIMO: ', ' DESCRIPCION: ');
        readln(cel.stockDisp, cel.stockMin, cel.descripcion);
        writeln('NOMBRE DEL CELULAR: ');
        readln(cel.nombre);

        write(c, cel);
        writeln('Celular Agregado');

        writeln('Desea agregar un celular al archivo:');
        writeln('1. Si');
        writeln('2. No');
        readln(num);
    end;

    close(c);
    writeln('Presione ENTER para terminar..');
    readln();
end;

procedure modificarStock(var c: archivo);
var
    cel: celular;
    nombre: string[30];
    existe: boolean;
    stock: integer;
begin
    existe:= false;
    writeln('Ingrese el nombre del celular:');
    readln(nombre);

    reset(c);
    while not eof(c) and (existe = false) do begin
        read(c, cel);
        if(cel.nombre = nombre) then begin
            existe:= true;
            writeln('Celular encontrado: ');
            writeln('Ingrese el nuevo stock: ');
            readln(stock);
            cel.stockDisp:= stock;
            seek(c, filepos(c)-1);
            write(c, cel);
            writeln('Stock modificado correctamente.');
        end;
    end;

    close(c);
    if(existe = false) then
        writeln('Celular no encontrado.');

    writeln('Presione ENTER para terminar..');
    readln();
end;

procedure sinStockTxt(var c: archivo);
var
    cel: celular;
    txt: text;
begin
    writeln('Buscando los celulares sin Stock...');
    assign(txt, 'SinStock.txt');
    rewrite(txt);
    reset(c);
    while not eof(c) do begin
        read(c,cel);
        if(cel.stockDisp = 0) then begin
            writeln(txt, cel.cod, cel.precio, cel.marca);
            writeln(txt, cel.stockDisp, cel.stockMin, cel.descripcion);
            writeln(txt, cel.nombre);
        end;
    end;

    close(c);
    close(txt);

    writeln('El archivo "SinStock.txt" fue creado con exito.');
    writeln('Presione Enter para terminar...');
    readln();
end;



var
    c: archivo;
    nombre: string;
    opcion: integer;
begin
    
    writeln('Bienvenido/a a TIENDA DE CELULARES');
    repeat
        writeln('--------- MENU PRINCIPAL----------');
        writeln('Seleccione una Opcion:');
        writeln('1. Crear un nuevo archivo binario de los celulares.');
        writeln('2. Listar celulares con stock por debajo del minimo.');
        writeln('3. Listar celulares que contengan descripcion.');
        writeln('4. Exportar archivo a texto.');
        writeln('5. Agregar celulares al archivo.');
        writeln('6. Modificar el stock disponible de un celular.');
        writeln('7. Exportar a archivo de texto celulares sin stock.');
        writeln('0. Salir.');
    
        readln(opcion);

        case opcion of
            1: begin
                writeln('Asigne un nombre al nuevo archivo:');
                readln(nombre);
                assign(c, nombre + '.dat');
                importarCelulares(c);
            end;
            2: begin
                bajoStock(c);
            end;
            3:  begin
                buscarDescripcion(c);
            end;
            4:  begin
                exportarTxt(c);
            end;
            5: begin
                agregarCelulares(c);
            end;
            6: begin
                modificarStock(c);
            end;
            7: begin
                sinStockTxt(c);
            end;
            0: writeln('Saliendo del programa...');
            else
                writeln('Opcion Invalida. Intente de nuevo');
        end;
    until(opcion = 0);
    writeln('Adios!');
    readln();


end.