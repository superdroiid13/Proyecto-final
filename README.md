# Proyecto-final
# Proyecto Final AON - Simulación AWS Local

## Qué es
Este proyecto simula un entorno AWS local usando **LocalStack** y **Terraform**.  
Permite crear recursos de nube (S3, DynamoDB, SQS, Security Group) sin usar cuentas reales de AWS.

## Requisitos
- Docker y Docker Compose
- Terraform >= 1.0
- AWS CLI (opcional)
- Archivo `index.html` simple

## Cómo usar

### 1. Levantar LocalStack
```bash
docker-compose up -d
docker ps  # verificar que el contenedor esté corriendo

## Desplegar infraestructura con Terraform
terraform init
terraform apply -auto-approve

## Verificar recursos

DynamoDB:
aws --endpoint-url=http://localhost:4566 dynamodb list-tables --region us-east-1

S3:
aws --endpoint-url=http://localhost:4566 s3 ls --region us-east-1

SQS:
aws --endpoint-url=http://localhost:4566 sqs list-queues --region us-east-1

Nota: EC2 no funciona en LocalStack Community, Security Group es solo conceptual.

Limpiar

terraform destroy -auto-approve
docker-compose down

Notas

Las claves AWS usadas son falsas (test) y solo sirven con LocalStack.

Todo el tráfico de Terraform se redirige al contenedor local.

Esto simula una arquitectura serverless simple con almacenamiento, base de datos y mensajería.
