# IaC Infraestructura como Código - AWS Demo 03
Creacion del código necesario para desplegar en la nube de AWS la infraesctructura compuesta por:
- Aurora and RDS - Base de datos relacional, nos sirve para ver el funcionamiento de la bases de datos Transaccionales OLTP
- EC2 - Es una maquina virtual (pc)
- EBS - Almacenamiento conectado a la EC2 (disco duro)
- VPC - Red virtual privada donde están todos mis recuros
- Subnet - Subred dentro de la VPC (privada y publica)
- IAM - Servicio para gestionar las politicas y roles (permisos)

Mediante lenguaje SQL se realizan consultas para crear las tablas e insertar datos de ejemplo
Luego, se realiza una transacción llevando cierto valor de un usuario a otro para mostrar las caracteristicas ACID de OLTP como son: Atomicidad, Consistencia, Aislamiento y Durabilidad de los datos

<!-- imagen -->
![Arquitectura](https://github.com/Wilalz/Data-Engineer-Demos-AWS/blob/8aac5a648f40d6878b21d12bfdc418e61f2310e3/03-Infra-RDS-OLTP-DataBase/AWS%20infra%20RDS%20OLTP.jpg)


## Instalación
Clona o descarga el repósitorio\
Aprovicionar la infraestructura en AWS

Contar un gestor de bases de datos como DBeaver o DataGrip
Hacer la conexion a la base de datos
Ejecutar el paso a paso de la consultas del archivo "practica_acid.sql"

...

## Tecnologias utilizadas
AWS | SQL | OLTP | ACID | DBeaver | DataGrip

## Participantes
Wilson Alzate

## Contacto
[Wilson Alzate (LinkedIn)](https://www.linkedin.com/in/wilson-alzate-pineda/)



## .
