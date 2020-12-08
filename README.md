# Alembic Docker image
Creates docker image with installed alembic python library from https://github.com/FilipSivak/alembic for loading Alembic 3D files in python.

Dockerfile:
| Package   | Version |
|-----------|---------|
| Ubuntu    | 18.04   |
| python    | 2.7     |
| CMake     | latest  |
| ilmbase   | 2.2.0   |
| pyilmbase | 2.2.0   |
| alembic   | 1.7.16  |

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
