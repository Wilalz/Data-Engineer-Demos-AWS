# Demo 05 - Data warehouse con Redshift AWS 
Demo para crear un data warehouse con Amazon Redshift a partir de los archivos .csv existentes en un bucket S3

- S3 - Contiene los archivos .csv
- Redshift - Se crean las tablas apartir de los archivos .csv
- Permios IAM - Para permitir el acceso a los datos del S3


<!-- imagen -->
![Arquitectura](xxx)


## Instalación

### Crear la infra

Crear un bucket S3 (Datalake)

- uso general, darle un nombre
- Entrar y crear una carpeta “contoso_sales”
- Cargar los archivos CSV de contoso

Crear un Redshift (Data Warehouse)

- Tener en cuenta que Redshift sin servidor no está en la capa gratuita, pero ofrece un crédito de 300 USD para usarlo
- Ir a la prueba gratuita
- Crear un grupo de trabajo - para establecer el procesamiento y las bases de datos que tendrá
- Definir el nombre del grupo de trabajo “wgredshiftcontoso”
- Establecer la capacidad basica de **RPU** (Redshift Processing Unities) que es la capacidad de procesamiento que tendrá la base de datos, entre mas RPU mas rápido pero tambien mas costoso. 1 RPU provee 16GB de memoria RAM, es decir que se calcula por el volumen de los datos que se cargarán en memoria
- Dejar la configuración de redes y seguridad por defecto, siguiente
- Establecer el espacio de nombres “contosodb”
- Nombre de base de datos dejar en “dev”
- Establecer permisos, Rol de IAM asociados
    - Crear un rol IAM, asocia para copiar y descargar los datos desde S3
    - Especificar el bucket S3 y seleccionar el bucket creado
    - Crear rol de IAM como predeterminado
    - Copiar el rol creado, siguiente
    - Crear, y esperar
    

### Queries al data warehouse Redshift

- Boton Datos de consulta y se abrirá el Redshift Query Editor
- Seleccionar el proveedor que creamos y en el esquema publico copiar las tablas con el tipo de producto . Ver archivo “querys.sql”
    - Al ingresar al redshift query editor v2, me pide selecionar Connnect to d5_wgroup:
        - Federal user: sin contraseñas, acceso centralizado
        - Data user name and password:  con usuario y contraseña
        - AWS secrets manager: otro servicio para mantener las contraseñas fuera del cocigo
- SeleccionarFederal connection
- Ir al servidor “d5-dwh-wgroup”, native databases, dev, public, tables
      
- Ir al archivo querys.sql
    - Crear cada tabla, con el tipo de dato, y tamaño de dato, si admite null, restricciones para las primary key
    
    ```sql
    CREATE TABLE IF NOT EXISTS public.dimgeography (
        GeographyKey         INT            NOT NULL,
        GeographyType        VARCHAR(50),
        ContinentName        VARCHAR(100),
        CityName             VARCHAR(100),
        StateProvinceName    VARCHAR(100),
        RegionCountryName    VARCHAR(100),
    
        -- Opcional: Constraint de PK
        CONSTRAINT pk_dimgeography PRIMARY KEY (GeographyKey)
    )
    DISTSTYLE AUTO
    SORTKEY (GeographyKey);
    ```

    - copiar los datos desde el archivo que está en el S3, aplicando el permiso creado
        - COPY dev.public.dimgeography - define que va a copiar en la base de datos **dev**, esquema **public**, nombre de la tabla dimgeography
        - FROM - ruta **URI** del archivo csv dentro del S3
        - IAM_ROLE - indica **ARN** el rol creado, ir a IAM / Roles / AmazonRedshift-CommandsAccessRole-20250602T230640
        - FORMAT AS CSV DELIMITER ‘,’ QUOTE ‘”’ IGNOREHEADER 1 - indica el formate de como deberá interpretar el archivo CSV
        - REGION AS ‘us-east-1’ - define la region donde está el S3
    
    ```sql
    COPY dev.public.dimgeography FROM 's3://s3-warehouse-demo-dc/contoso_sales/DimGeography.csv' IAM_ROLE 'arn:aws:iam::135808920063:role/service-role/AmazonRedshift-CommandsAccessRole-2025602T26' FORMAT AS CSV DELIMITER ',' QUOTE '"' IGNOREHEADER 1 REGION AS 'us-east-1'
    
    -- reemplazar la ubicacion del archivo CSV y el codigo del rol por el creado "AmazonRedshift-CommandsAccessRole-2025602T26"
    ```
    
    Se verán los registros cargados
    
    Ya se pueden ejecutar consultas a las bases de datos, si analizamos la tablas de fact_sales veremos que en su mayoria está compuesta de codigos numericos haciendo referencia a las primary keys de las tablas de dimensión
    
    Base de datos relacional
    

    ### Puntos de conexion a la DWH
    
    Para conexión desde aplicaciones u otros servicios debemos ir a la configuración del grupo de trabajo y seleccionar la base de datos, allí se encontrará el link de punto de conexion, url de ODBC. JDBC. 
    
    Tener en cuenta que:
    
    - Se debe instalar el driver de Redshiftx64 para la conexion
    - Se deberá activar accesibilidad publica para poder acceder a ella
    
    ### Siempre elimine la infra no utilizada
    
    - Elimine las tablas creadas y cierra el Query Editor
    - Elimine el workgroup - Redshift → Workgroups
    - Elimine los Namespaces - Borra compute & storage; no quedan GB en metastore
    - Elimina Snapshots (pestaña “Snapshots”) - borra manuales que pudieras haber creado
    - Elimine los datos del bucket S3
    - Elimine Ips elastica (publica) y ENIs (interfaces de red)


## Tecnologias utilizadas
AWS | SQL | Data warehouse | OLAP

## Participantes
Wilson Alzate

## Contacto
[Wilson Alzate (LinkedIn)](https://www.linkedin.com/in/wilson-alzate-pineda/)



## .

