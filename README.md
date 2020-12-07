# Alembic Docker image
Creates docker image with installed alembic python library from https://github.com/FilipSivak/alembic for loading Alembic 3D files in python.

## Building
Adjust `sources.list` for your country mirror for Ubuntu bionic.
```
make build
```

or:
```
docker build -t alembic .
```

## Running
```
make bash
```

or:
```
docker run -it --rm alembic
```

## Building and running jupyter notebook
Build:
```
make build-jupyter
```

Run:
```
make jupyter
```
