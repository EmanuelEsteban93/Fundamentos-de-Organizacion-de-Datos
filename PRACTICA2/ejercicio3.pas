Program Ejercicio3;

Const

    VALOR_ALTO = 'ZZZZ';

Type
    encuestaM = record
        nombreProv: string[50];
        alfabetizados: integer;
        cantEncuestados: integer;
    end;

    encuestaD = record
        nombreProv: string[50];
        codLocalidad: integer;
        alfabetizados: integer;
        cantEncuestados: integer;
    end;

    archivoMaestro = file of encuestaM;
    archivoDetalle = file of encuestaD;


procedure leer(var d: archivoDetalle; var regD: encuestaD);
begin
    if not eof(d) then
        read(d, regD)
    else 
        regD.nombre:= VALOR_ALTO;
end;

procedure minimo(var d1: archivoDetalle; var d2: archivoDetalle;
                    var reg1: encuestaD; var reg2: encuestaD;
                     var regMinimo: encuestaD);
begin
    if(reg1.nombre <= reg2.nombre) then begin
        regMinimo:= reg1;
        leer(d1, reg1);
    end
    else begin
        regMinimo:= reg2;
        leer(d2, reg2);
    end;
end;


Var


begin
    
end.