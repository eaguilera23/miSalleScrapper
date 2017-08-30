![](http://i.imgur.com/MvqaIGv.png)

# miSalle

miSalle fue un producto dirigido a los alumnos de la Universidad De La Salle Bajío,
hecho por un alumno, pero fue bloqueado por la administración de la universidad.

En este repositorio encontrarás la parte del servidor que obtiene la información de los alumnos,
y la regresa como un `json` listo para su consumo.

## Features

Con miSalle puedes obtener:

- Información del alumno
- Horario
- Créditos
- Calificaciones 

## Prerequisitos

Para utilizar miSalle necesitarás:

- `ruby 2.4.0`
- `postgresql`
- `bundle`

## Instalación

```
$ git clone https://github.com/lalo2302/miSalleScrapper.git
$ cd miSalleScrapper
$ bundle install
$ rake db:create
$ rake db:migrate
```

## Usar

Para correr miSalle:
```
bundle exec rakup -p 3000
```

### Usar rutas

Para obtener la información del alumno, teniendo su matricula, contraseña y sistema:

Ejemplo de sistema:

- Lomas del campestre:
  - Licenciatura: 1
  - Profesional asociado: 4
  - Especialidad: 5
  - Maestría: 6
- Juan Alonso de Torres
  - Preparatoria: 43
- Américas
  - Preparatoria: 33
- Salamanca
  - Licenciatura 1: 20
  - Licenciatura 2: 21
  - Preparatoria: 23
  - Especialidad: 25
  - Maestría: 26
- San Francisco del Rincón
  - Secundaria: 12
  - Preparatoria: 13

Información de un alumno:
```
curl -H "Content-Type: application/json" -X POST -d '{"matricula": "XXXXX", "password": "XXXXXX", "sistema": X}' http://localhost:3000/api/v1/alumno
```

Créditos de un alumno:
```
curl -H "Content-Type: application/json" -X POST -d '{"matricula": "XXXXX", "password": "XXXXXX", "sistema": X}' http://localhost:3000/api/v1/creditos
```

Calificaciones de un alumno:
```
curl -H "Content-Type: application/json" -X POST -d '{"matricula": "XXXXX", "password": "XXXXXX", "sistema": X}' http://localhost:3000/api/v1/periodos
```

### Descripción del sistema (en progreso)

En este archivo se encuentra la lógica sobre la navegación a las diferentes rutas de la universidad,
para la obtención de los datos. Específicamente en el método `Navegador.parsear`
```
navegador.rb
```

Dependiendo qué información se desea consultar, se envia a uno de estos archivos para transformarla
y poderla manipular
```
parser/
```

