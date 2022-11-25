#!/bin/bash
mlflow server \
    --backend-store-uri sqlite:////mnt/backend_store/mlflow.db \
    --default-artifact-root /mnt/artifacts \
    --workers 2 \
    --host 0.0.0.0
