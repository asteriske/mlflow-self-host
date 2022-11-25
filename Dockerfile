FROM python:3.10.7-slim-bullseye

WORKDIR /app

COPY requirements.txt .

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install build-essential -y

RUN pip install -r requirements.txt 

COPY . .
 
RUN groupadd -g 1000 mlflow_grp && \
    useradd -r -u 1000 -g mlflow_grp mlflow_user --home /home/mlflow_user && \
    chown -R mlflow_user /app

RUN mkdir -p /mnt/backend_store /mnt/artifacts && \
    chown -R mlflow_user /mnt/backend_store && \
    chmod a+rwx -R /mnt/backend_store && \
    chown -R mlflow_user /mnt/artifacts && \
    chmod a+rwx -R /mnt/artifacts && \
    chmod +x entrypoint.sh
 

ENV PYTHONUNBUFFERED TRUE

ENTRYPOINT ["./entrypoint.sh"]
