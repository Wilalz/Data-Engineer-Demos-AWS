# IaC Infraestructura como Código - AWS Demo 03
Creacion del código necesario para desplegar en la nube de AWS la infraesctructura compuesta por:
- Aurora and RDS - Instancia para base de datos relacional (Postgres), nos sirve para ver el funcionamiento de la bases de datos Transaccionales OLTP
- VPC - Red virtual privada donde están todos mis recuros
- Subnet - Subredes publicas dentro la VPC y distribuidas en zonas de disponibilidad distintas
- IAM - Servicio para gestionar las politicas y roles (permisos)
- IGW - Internet Gateway para habilitar acceso externo controlado
- Grupo de seguridad - Permite conexiones al puerto 5432 exclusivamente desde una IP específica

Con un cliente externo de base de datos como DBeaver y mediante lenguaje SQL, se realizan consultas para crear las tablas e insertar datos de ejemplo.
Luego, se realiza una transacción llevando cierto valor de un usuario a otro para mostrar las caracteristicas ACID de OLTP como son: Atomicidad, Consistencia, Aislamiento y Durabilidad de los datos

La mayoria de recuros estan optimizados para operar dentro de los límites de la capa gratuita (Free Tier) sin embargo, al activar MakeRDSPublic en true se generarán cobros porque se establece una ip publica fija. (ver archivo costos_generados_primer_infra.md)

<!-- imagen -->
![Arquitectura](https://github.com/Wilalz/Data-Engineer-Demos-AWS/blob/1ecf472eea7d313c5a1d225c5561b566ab53405b/03-Infra-RDS-OLTP-DataBase/AWS%20infra%20RDS%20OLTP.png)


## Instalación
Clona o descarga el repósitorio\
Aprovicionar la infraestructura en AWS

Contar un gestor de bases de datos como DBeaver o DataGrip
Hacer la conexion a la base de datos
Ejecutar el paso a paso de la consultas del archivo "practica_acid.sql"

...

## Tecnologias utilizadas
AWS | SQL | OLTP | ACID | DBeaver

## Participantes
Wilson Alzate

## Contacto
[Wilson Alzate (LinkedIn)](https://www.linkedin.com/in/wilson-alzate-pineda/)



## .
