# IaC Infraestructura como Código - AWS Demo 01
Creacion del código necesario para desplegar en la nube de AWS la infraesctructura compuesta por:
- Step function - que coordina la ejecución de lambdas
- Lambdas
    - Primera - obtiene datos de una API y escribe los datos en el almacenamiento S3 en la carpeta 'raw', tambien pasa algunos de los datos a la siguiente lambda
    - Segunda - recibe los datos de la primera lambda, los transforma y los almacena en la S3 en la carpeta 'results'
- S3 - Servicio para el almacenamiento de los datos
- IAM - Servicio para gestionar las politicas (permisos) para invocar las lambdas y para escritura en S3

<!-- imagen -->
![Arquitectura](https://github.com/Wilalz/Data-Engineer-Demos-AWS/blob/03ad6be8b7f027acaed200b4342afc0dc1e26725/01-Infa-StepFunction-Lambdas-S3/AWS_Step_function_Lambdas_S3.jpg)


## Instalación
Clona o descarga el repósitorio\
...

## Tecnologias utilizadas
AWS | 

## Participantes
Wilson Alzate

## Contacto
[Wilson Alzate (LinkedIn)](https://www.linkedin.com/in/wilson-alzate-pineda/)



## .
