import os
import boto3
from datetime import datetime

bucket_name = os.getenv('INPUT_BUCKET_NAME')
region = os.getenv('AWS_REGION')

if not bucket_name:
    raise ValueError("La variable de entorno INPUT_BUCKET_NAME no está definida.")

# Crear cliente S3 usando la región
s3 = boto3.client('s3', region_name=region)

carpeta_csv = './csv'
archivos_csv = [f for f in os.listdir(carpeta_csv) if f.endswith('.csv')]

if not archivos_csv:
    print("⚠️ No se encontraron archivos .csv en la carpeta.")
else:
    for archivo in archivos_csv:
        ruta_local = os.path.join(carpeta_csv, archivo)
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        nombre_base = os.path.splitext(archivo)[0]
        s3_key = f"archivos/{nombre_base}_{timestamp}.csv"

        try:
            s3.upload_file(ruta_local, bucket_name, s3_key)
            print(f"✅ Subido: {ruta_local} → s3://{bucket_name}/{s3_key}")
        except Exception as e:
            print(f"❌ Error al subir '{archivo}': {e}")
