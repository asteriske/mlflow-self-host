version = $(file < version.txt)

build:
	docker build -t registry.lan:5000/mlflow:v$(version) .

push:
	docker push registry.lan:5000/mlflow:v$(version)

pushlatest:
	docker build -t registry.lan:5000/mlflow:latest .
	docker push registry.lan:5000/mlflow:latest
