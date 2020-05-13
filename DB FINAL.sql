----------------------------------------------------------------------------
CREATE TABLE GENERO
( 
IdGenero char NOT NULL,
Descripcion varchar2(50) NOT NULL, 
CONSTRAINT pk_genero PRIMARY KEY (IdGenero)
);

----------------------------------------------------------------------------
INSERT INTO GENERO (IdGenero, Descripcion)
VALUES ('F', 'Femenino');

INSERT INTO GENERO (IdGenero, Descripcion)
VALUES ('M', 'Masculino');

----------------------------------------------------------------------------
CREATE TABLE CLASIFICACION_PERSONA
( 
IdClasificacionPersona int NOT NULL,
Descripcion varchar2(50) NOT NULL, 
CONSTRAINT pk_clasificacion_persona PRIMARY KEY (IdClasificacionPersona)
);

----------------------------------------------------------------------------
INSERT INTO CLASIFICACION_PERSONA (IdClasificacionPersona, Descripcion)
VALUES (1, 'Empleado');

INSERT INTO CLASIFICACION_PERSONA (IdClasificacionPersona, Descripcion)
VALUES (2, 'Empleado Externo');

INSERT INTO CLASIFICACION_PERSONA (IdClasificacionPersona, Descripcion)
VALUES (3, 'Proveedor');

INSERT INTO CLASIFICACION_PERSONA (IdClasificacionPersona, Descripcion)
VALUES (4, 'Visita');

INSERT INTO CLASIFICACION_PERSONA (IdClasificacionPersona, Descripcion)
VALUES (5, 'Director');
----------------------------------------------------------------------------

CREATE SEQUENCE SEC_PERSONAS
MINVALUE 1
INCREMENT BY 1
NOCYCLE
NOCACHE;

----------------------------------------------------------------------------
CREATE TABLE PERSONAS
(
IdPersona number NOT NULL, --autonumerico
Dni varchar2(11) NOT NULL, -- unique si es persona nro de dni
Apellidos varchar2(100) NOT NULL, 
Nombres varchar2(100) NOT NULL, 
IdGenero char NOT NULL, --F si es femenino M si es masculino
TelefonoPersonal varchar2(30) NOT NULL, 
EmailPersonal varchar2(100) NOT NULL, 
Foto varchar2(255) NOT NULL, --se guarda la ubicacion de la foto, si no tiene poner no disponible
IdClasificacionPersona number NOT NULL, 
CONSTRAINT pk_personas PRIMARY KEY (IdPersona),
CONSTRAINT fk_genero FOREIGN KEY (IdGenero) REFERENCES GENERO(IdGenero),
CONSTRAINT fk_clasificacionPersona FOREIGN KEY (IdClasificacionPersona) REFERENCES CLASIFICACION_PERSONA(IdClasificacionPersona),
CONSTRAINT unq_dni UNIQUE (Dni),
CONSTRAINT unq_emailPersonal UNIQUE (EmailPersonal)
);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO PERSONAS(IDPERSONA, DNI, APELLIDOS, NOMBRES, IDGENERO, TELEFONOPERSONAL, EMAILPERSONAL, FOTO, IDCLASIFICACIONPERSONA )
VALUES (SEC_PERSONAS.NEXTVAL, '33265485', 'CORREA', 'BENJAMIN JOSUE', 'M','(0351) 153896193', 'benjacordoba@gmail.com', 'Z:\Personas\FotosPerfil\32204561.png',  1);

INSERT INTO PERSONAS(IDPERSONA, DNI, APELLIDOS, NOMBRES, IDGENERO, TELEFONOPERSONAL, EMAILPERSONAL, FOTO, IDCLASIFICACIONPERSONA )
VALUES (SEC_PERSONAS.NEXTVAL, '28562548', 'PEREZ', 'MIRIAM', 'F','(03548) 15469335', 'juami@gmail.com', 'Z:\Personas\FotosPerfil\28562548.png',  1);
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE ESTADO
( 
IdEstado number NOT NULL,
Descripcion varchar2(50) NOT NULL, --activo -inactivo --bloqueado -suspendido
CONSTRAINT pk_estado PRIMARY KEY (IdEstado)
);

----------------------------------------------------------------------------
INSERT INTO ESTADO (IdEstado, Descripcion)
VALUES (0, 'INACTIVO');

INSERT INTO ESTADO (IdEstado, Descripcion)
VALUES (1, 'ACTIVO');

INSERT INTO ESTADO (IdEstado, Descripcion)
VALUES (2, 'BLOQUEADO');

INSERT INTO ESTADO (IdEstado, Descripcion)
VALUES (3, 'SUSPENDIDO');

----------------------------------------------------------------------------

CREATE SEQUENCE SEC_PERFILES
MINVALUE 1
INCREMENT BY 1
NOCYCLE
NOCACHE;

----------------------------------------------------------------------------

CREATE TABLE PERFILES
( 
IdPerfil number NOT NULL,
Descripcion varchar2(100) NOT NULL,
CONSTRAINT pk_perfiles PRIMARY KEY (IdPerfil)
);

INSERT INTO PERFILES (IdPerfil, Descripcion)
VALUES (SEC_PERFILES.NEXTVAL, 'ADMINISTRADOR - ACCESO TOTAL');

INSERT INTO PERFILES (IdPerfil, Descripcion)
VALUES (SEC_PERFILES.NEXTVAL, 'ADMINISTRADOR - TESTING');

----------------------------------------------------------------------------

CREATE SEQUENCE SEC_USUARIOS
MINVALUE 1
INCREMENT BY 1
NOCYCLE
NOCACHE;

----------------------------------------------------------------------------

CREATE TABLE USUARIOS
(
IdUsuario number NOT NULL, --AUTONUMERICO
IdPersona number NOT NULL, --FK CON LA TABLA PERSONA
DisplayName varchar2(50) NOT NULL, --NOMBRE PARA MOSTRAR, INDEPENDIENTEMENTE DEL NOMBRE REAL, PERO PREDEFINIDO NOMBRE REAL TOMADO DE LA TABLA PERSONA
NetworkUser varchar2(50) NOT NULL, -- UNIQUE HOSTNAME\USER, SI NO TIENE HOSTNAME\USER_NRO_DNI
Username varchar2(50) NOT NULL, -- UNIQUE NOMBRE DE USUARIO
PasswordHash varchar2(255) NOT NULL, --PASSWORD CIFRADA
PasswordSalt varchar2(255) NOT NULL, --SALT CARACTERES ALEATORIOS
Email varchar2(100) NOT NULL, -- UNIQUE ESTO ES PARA ENVIAR MAILS POR ALGUN PROCESO
FechaAlta date NOT NULL, -- PONER LA FECHA ACTUAL DE CREACION
IdPerfil number NOT NULL, --FK CON LA TABLA PERFIL
IdEstado number NOT NULL, -- FK ACTIVO, INACTIVO, REACTIVADO, BLOQUEADO
CONSTRAINT pk_usuarios PRIMARY KEY (IdUsuario),
CONSTRAINT fk_personas FOREIGN KEY (IdPersona) REFERENCES PERSONAS(IdPersona),
CONSTRAINT fk_perfiles FOREIGN KEY (IdPerfil) REFERENCES PERFILES(IdPerfil),
CONSTRAINT fk_estado FOREIGN KEY (IdEstado) REFERENCES ESTADO(IdEstado),
CONSTRAINT unq_networkUser UNIQUE (NetworkUser),
CONSTRAINT unq_username UNIQUE (Username),
CONSTRAINT unq_email UNIQUE (Email)
);

--------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO USUARIOS
(IDUSUARIO, IDPERSONA, DISPLAYNAME, NETWORKUSER, USERNAME, PASSWORDHASH, PASSWORDSALT, 
EMAIL, FECHAALTA, IDPERFIL, IDESTADO)
VALUES
(SEC_USUARIOS.NEXTVAL, 1, 'BENJA','SRV-RRHH\bcorrea', 'bcorrea','ZggJuLk4bZ3oj+sqsAa5XbSVM7xKtBR8HglUzm6JHqY=','Kq+oqVUORYCFZLE8v1LNUw==',
'benjamin.correa@cyre.com.ar', SYSDATE, 1, 1);

INSERT INTO USUARIOS
(IDUSUARIO, IDPERSONA, DISPLAYNAME, NETWORKUSER, USERNAME, PASSWORDHASH, PASSWORDSALT, 
EMAIL, FECHAALTA, IDPERFIL, IDESTADO)
VALUES
(SEC_USUARIOS.NEXTVAL, 2, 'MIMI','SRV-RRHH\mimi', 'mimi','ZggJuLk4bZ3oj+sqsAa5XbSVM7xKtBR8HglUzm6JHqY=','Kq+oqVUORYCFZLE8v1LNUw==',
'mimi@cyre.com.ar', SYSDATE, 1, 1);

--------------------------------------------------------------------------------------------------------------------------------------------------------
COMMIT;
--------------------------------------------------------------------------------------------------------------------------------------------------------