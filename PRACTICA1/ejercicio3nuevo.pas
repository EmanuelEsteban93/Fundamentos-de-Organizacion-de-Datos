Program Ejercicio3;

Type

    empleado = record
        nro: integer;
        apellido: string[30];
        nombre: string[30];
        edad: integer;
        dni: integer;
    end;

    archivo = file of empleado;

procedure usarArchivo(var e: archivo);
var
    nombreArc: string;
begin
    writeln('Ingrese el nombre del archivo: ');
    readln(nombreArc);
    assign(e, nombreArc + '.dat');
end;

procedure leerEmpleado(var emp: empleado);

begin
    writeln('Apellido (Para finalizar, ingrese "fin"): ');
    readln(emp.apellido);
    if(emp.apellido <> 'fin') then begin
        writeln('Nombre: ');
        readln(emp.nombre);
        writeln('Numero de empleado: ');
        readln(emp.nro);
        writeln('Edad: ');
        readln(emp.edad);
        writeln('DNI: ');
        readln(emp.dni);
    end;
end;


procedure crearArchivo(var e: archivo);
var
    emp: empleado;
    nombreArc: string;
begin
    writeln('Ingrese el nombre del archivo a crear: ');
    readln(nombreArc);
    assign(e, nombreArc + '.dat');
    rewrite(e);

    writeln('..........INGRESANDO EMPLEADOS.......');

    leerEmpleado(emp);

    while(emp.apellido <> 'fin')do begin
        write(e, emp);
        leerEmpleado(emp);
    end;

    close(e);
    writeln('El archivo ', nombreArc, ' ha sido CARGADO Y GUARDADO correctamente! ');
    writeln('Presione Enter para salir.');
    readln();
end;

procedure buscarEmpleado(var e: archivo);
var
    nombre: string[30];
    apellido: string[30];
    encontrado: boolean;
    emp: empleado;
begin
    encontrado:= false;
    reset(e);
    writeln('Ingrese el APELLIDO del empleado: ');
    readln(apellido);
    writeln('Ingrese el NOMBRE del empleado: ');
    readln(nombre);
    writeln('Buscando.....');

    while not eof(e) and (encontrado = false) do begin
        read(e, emp);
        if(emp.apellido = apellido)and(emp.nombre = nombre) then begin
            writeln('Se ha encontrado 1(una) coincidencia: ');
            writeln('EMPLEADO:');
            writeln('Apellido: ', emp.apellido);
            writeln('Nombre: ', emp.nombre);
            writeln('Numero de empleado: ', emp.nro);
            writeln('Numero de DNI:', emp.dni);
            writeln('Edad: ', emp.edad);
            encontrado:= true;
        end;
    end;

    close(e);
    if(encontrado = false) then
        writeln('Empleado No encontrado.');
    
    writeln('Pulse Enter para salir...');
    readln();
end;

procedure listarEmpleados(var e: archivo);
var
    emp: empleado;

begin
    reset(e);
    writeln('Listando archivo....');
    writeln('EMPLEADOS:');
    while not eof(e) do begin
        read(e, emp);

        writeln('------------------------------------------');
        writeln('Apellido: ', emp.apellido);
        writeln('Nombre: ', emp.nombre);
        writeln('Numero de empleado: ', emp.nro);
        writeln('Numero de DNI:', emp.dni);
        writeln('Edad: ', emp.edad);
        writeln('------------------------------------------');
    end;

    close(e);
    writeln('Listado finalizado.');
    writeln('Presione Enter para Finalizar.');
    readln();
end;

procedure proximosAJubilarse(var e: archivo);
var
    emp:empleado;
    noHay: boolean;
begin
    noHay:= true;
    reset(e);
    writeln('Listando empleados proximos a jubilarse: ');
    writeln('------------------------------------------');
    while not eof(e) do begin
        read(e, emp);
        if(emp.edad > 70)then begin
            noHay:= false;
            writeln('Apellido: ', emp.apellido);
            writeln('Nombre: ', emp.nombre);
            writeln('Numero de empleado: ', emp.nro);
            writeln('Numero de DNI:', emp.dni);
            writeln('Edad: ', emp.edad);
            writeln('------------------------------------------');
        end;
    end;
    if(noHay = true) then 
        writeln('No hay empleados proximos a Jubilarse.');
    
    close(e);
    writeln('Listado Completo.');
    writeln('Presione Enter para salir.');
    readln();
end;

procedure agregarAlArchivo(var e: archivo);
var
    emp: empleado;
    existe: boolean;
    numero: integer;
begin
    writeln('AGREGAR EMPLEADO/S AL ARCHIVO...');
    writeln('Ingrese el numero de Empleado:');
    writeln('Para terminar ingrese 0(cero)');
    readln(numero);

    while(numero <> 0) do begin
        existe:= false;
        reset(e);
        while not eof(e) and (existe = false) do begin
            read(e,emp);
            if(numero = emp.nro) then
                existe:=true;
        end;
        if(existe = false) then begin
            reset(e);
            seek(e, filesize(e));
            writeln('Apellido');
            readln(emp.apellido);
            writeln('Nombre: ');
            readln(emp.nombre);
            emp.nro:= numero;
            writeln('Edad: ');
            readln(emp.edad);
            writeln('DNI: ');
            readln(emp.dni);
            write(e, emp);
            writeln('El empleado fue agregado EXITOSAMENTE al archivo.');
        end
        else 
            writeln('Numero de empleado EXISTENTE. Ingrese otro distinto o ingrese 0(cero) para terminar.');
        writeln('----------------------------------------');
        writeln('Ingrese el numero de Empleado:');
        writeln('Para terminar ingrese 0(cero)');
        readln(numero);
    end;
    close(e);
    writeln('Ingrese Enter para finalizar:');
    readln();
end;

procedure modificarEdad(var e: archivo);
var
    numero: integer;
    emp: empleado;
    encontrado: boolean;
    nuevaEdad: integer;
begin
    encontrado:= false;
    writeln('Ingrese el numero del empleado al cual quiere modificar la edad');
    readln(numero);
    reset(e);
    while not eof(e) and (encontrado = false) do begin
        read(e, emp);
        if(emp.nro = numero) then begin
            encontrado:= true;
            writeln('Empleado encontrado!');
            writeln(emp.apellido,' ',emp.nombre, ' Nº  de empleado: ',emp.nro);
            writeln('----------------------------------');
            writeln('Ingresa la nueva edad del empleado:');
            readln(nuevaEdad);
            emp.edad:= nuevaEdad;
            seek(e, filepos(e)-1);
            write(e, emp);
            writeln('La edad fue modificadad correctamente.');
        end;
    end;
    close(e);
    if(encontrado = false)then
        writeln('Empleado Inexistente');
end;

procedure exportarATexto(var e:archivo);
var
    nombreFisico: string;
    emp: empleado;
    t:text;
begin
    writeln('Ingrese un nombre para el nuevo archivo de texto:');
    readln(nombreFisico);
    assign(t, nombreFisico + '.txt');
    rewrite(t);
    reset(e);

    while not eof(e) do begin
        read(e, emp);
        with emp do
            writeln(t, '', dni, ' ', nro, ' ', edad, ' ', apellido, ' ', nombre);
    end;
    close(e);
    close(t);
    writeln('El archivo ', nombreFisico + '.txt', ' fue descargado exitosamente.');
end;




var
    e: archivo;
    opcion: integer;
    texto: text;
Begin
    writeln('Bienvenido/a a mi programa: ');
    repeat
        writeln('--------- MENU PRINCIPAL----------');
        writeln('Seleccione una Opcion:');
        writeln('1. Crear un nuevo archivo y Cargar empleados.');
        writeln('2. Buscar empleados por NOMBRE y APELLIDO.');
        writeln('3. Listar empleados.');
        writeln('4. Buscar empleados proximos a jubilarse.');
        writeln('5. Agregar empleado/s.');
        writeln('6. Modificar edad de empleado.');
        writeln('0. Salir.');
    
        readln(opcion);

        case opcion of
            1: crearArchivo(e);
            2: begin
                usarArchivo(e);
                buscarEmpleado(e);
            end;
            3:  begin
                usarArchivo(e);
                listarEmpleados(e);
            end;
            4:  begin
                usarArchivo(e);
                proximosAJubilarse(e);
            end;
            5: begin
                usarArchivo(e);
                agregarAlArchivo(e);
            end;
            6: begin
                usarArchivo(e);
                modificarEdad(e);
            end;
            0: writeln('Saliendo del programa...');
            else
                writeln('Opcion Invalida. Intente de nuevo');
        end;
    until(opcion = 0);
    writeln('Adios!');
    readln();

End.