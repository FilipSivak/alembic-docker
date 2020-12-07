build:
	docker build -t alembic .

build-jupyter:
	docker build -t alembic-jupyter -f Dockerfile.jupyter .

bash:
	docker run -it --rm alembic

jupyter:
	docker run -p 8899:8899 -w /tmp/jupyter --mount type=bind,source="$(shell pwd)",target=/tmp/jupyter alembic-jupyter
