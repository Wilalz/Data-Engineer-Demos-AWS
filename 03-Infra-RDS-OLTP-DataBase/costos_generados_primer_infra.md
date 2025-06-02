# Costos de infraestructura desplegada en demo 3 (RDS OLTP Database)
Ojo, la infra desplegada con el archivo rds_postgres.yaml generó costos!

## Por qué se han generado los costos?
El yaml usado tiene algunos inconvenientes:
- Crea una base de datos PostgreSQL (RDS) con backups automáticos que exceden la capa gratuita de 20 GB
- Crea dos subredes públicas con IP pública asociada a la infra de red (VPC). AWS cobra por IP estática asignada pero no usada (apagada). En las subnets está MapPublicIpOnLaunch está en true
- Desde hace un tiempo AWS tambien cobra si una RDS tiene ip publica. Este punto no puede mejorarse ya que es una politica de AWS y que está fuera de la capa gratuita. La unica forma que no cobre es desabilitando el acceso publico (hay otras opciones de conexion)

## Qué hacer para detener los costos?
- Eliminar la instancia RDS	Si ya no la necesitas
- Eliminar backups adicionales:	Mantén solo 1 o reduce BackupRetentionPeriod a 0
- Libera las Elastic IP (públicas) no usadas
- Evita mantener recursos encendidos todo el mes si no los usas

## Nueva version dentro de la capa gratuita
Se genera un nuevo archivo para asegurar que se aprovicionar la infraestructura necesaria, esta configuración no está pensada para producción, ya que carece de redundancia, backups y alta disponibilidad. El enfoque está en minimizar costos y mantener visibilidad del sistema

### Ventajas y desventajas de la nueva versión
Ventajas de la nueva versión:
- Capa gratuita asegurada: uso de db.t4g.micro, almacenamiento limitado y sin backups automáticos.
- Se elimina la IP Elastica de las subnets con MapPublicIpOnLaunch: false
- Acceso seguro: la conexión desde herramientas externas como DBeaver está permitida, pero limitada a una IP pública específica.
- Infraestructura limpia: incluye solo los componentes necesarios (RDS, VPC, subredes, rutas) sin exceso de servicios que generen cargos.
- Portabilidad: gracias al uso de parámetros (AllowedIP, DBUsername, DBPassword), el template es fácilmente reutilizable.

Desventajas:
- La base de datos es accesible desde Internet (aunque controlada): esto representa una superficie de ataque si no se maneja correctamente. Se deben aplicar buenas prácticas de seguridad, como restringir IPs, usar contraseñas seguras y eliminar recursos cuando no se usen.
- Sin protección de eliminación: Puedes borrar accidentalmente la DB
- Sin backup automático: Si borras la DB por error, no hay recuperación
- Almacenamiento limitado: si el proyecto crece, será necesario redimensionar, saliéndose del Free Tier.

## Qué riesgos potenciales de costos siguen existiendo?
Aunque esta versión está optimizada para el Free Tier, existen algunos riesgos si no se gestiona correctamente:

- Tener más de una instancia encendida, o varias regiones - Puedes usar hasta 750 horas gratis
- Crear más de una RDS o aumentar almacenamiento - El límite de 20 GB es total (entre todas las RDS y backups)
- Backups (snapshots) manuales nunca están cubiertos por Free Tier, y no se eliminan al borrar la RDS.
- Eliminar la RDS y dejar backups generá cobro por almacenamiento
- RECORDAR! que si se activa el MakeRDSPublic en true hace la RDS publica y generará cobro por hora de uso por la ip. 

## Recomendación final: eliminar todo lo que no tiene en uso
Paso a paso de eliminación de infraestructura aprovicionada

1. Hacer backup manual (opcional).
    - En RDS → Take snapshot (esto sí se cobra hasta que lo borres).
2. Eliminar la pila CloudFormation.
    - Selecciona la pila
    - Acciones → Delete.
    - Espera a que el estado sea DELETE_COMPLETE.
3. Limpiar recursos huérfanos (si los hubiera).
    - Elastic IP (ip publica fija) → debe quedar vacía → Ver EC2
    - Network Interfaces → solo la ENI “default” o ninguna → Ver EC2
    - Volumes / Snapshots (backups) → Ver EC2 y RDS
    - EBS volumenes de almacenamiento → Ver Ec2
4. Re-chequear Cost Explorer al día siguiente, si se hizo bien, el gasto diario mostrará 0 USD.

