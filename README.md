![](http://i.imgur.com/MvqaIGv.png)

# miSalle

## Table of contents

* [Presentation](#presentation)
  * [Characteristics](#characteristics)
  * [Requirements](#requirements)
  * [Instalation](#instalation)
  * [Usage](#usage)
  * [Routes](#routes)
  * [System description](#system-description)
* [Documentation](#documentation)
  * [Analysis](#analysis)
      * [Problem description](#problem-description)
      * [Impact](#impact)
      * [Background](#background)
      * [Objective](#objective)
      * [Scope](#scope)
      * [Out Of Scope](#out-of-scope)
      * [Cost](#cost)
      * [Benefit](#benefit)
      * [Future](#future)
      * [Functional Requirements](#functional-requirements)
      * [Non Functional Requirements](#non-functional-requirements)
      * [Risks](#risks)
      * [High Level Design](#high-level-design)
      * [Data Flow Analysis](#data-flow-analysis)
      * [Screen Analysis](#screen-analysis) 
  * [System Design](#system-design)
      * [Class Diagram](#class-diagram) (May be outdated)
      * [Architecture Modules](#architecture-modules)
      * [Color Palette](#color-palette)
      * [UI prototype](#ui-prototype)
  * [API Spec](#api-spec)
* [Aknowledgements](#aknowledgements)

## Presentation

miSalle was a product for the students of the Universidad De La Salle Bajío,
but the server was blocked due to conflict of interests by the institution administration.

In this repository you will find the server side of the product, which gets the students information from
the university system, and returns it as a 'json' for its manipulation.

### Characteristics

With miSalle you can get:

- Student personal information
- Schedule
- Credits
- Grades 

### Requirements

You will need to run miSalleScrapper:

- `ruby 2.4.0`
- `postgresql`
- `bundle`

### Instalation

```
$ git clone https://github.com/lalo2302/miSalleScrapper.git
$ cd miSalleScrapper
$ bundle install
$ rake db:create
$ rake db:migrate
```

### Usage

For running miSalleScrapper:
```
bundle exec rakup -p 3000
```

### Routes

To get the student information, you need its enrollment number, password and system:

System numbers:

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

All the student information:
```
curl -H "Content-Type: application/json" -X POST -d '{"matricula": "XXXXX", "password": "XXXXXX", "sistema": X}' http://localhost:3000/api/v1/alumno
```

Student credits:
```
curl -H "Content-Type: application/json" -X POST -d '{"matricula": "XXXXX", "password": "XXXXXX", "sistema": X}' http://localhost:3000/api/v1/creditos
```

Student grades:
```
curl -H "Content-Type: application/json" -X POST -d '{"matricula": "XXXXX", "password": "XXXXXX", "sistema": X}' http://localhost:3000/api/v1/periodos
```

### System description

Every request to the system, will be processed by the file `app/router_v1.rb`

The university expended the username and password of the student, but the system doesn't really need those.
I only implemented it to verify the identity of the user. If you want to get any student's information,
go to `app/navegador.rb`

In this file you will find the logic that navigates the university system for the data extraction.
For further specification, go to `Navegador.parsear`

Once the `navegador.rb` gets the webpage needed, it sends the information to the files inside `app/parser/`. There the
system manipulates the data to serve it as a `json`.

# Documentation

## Analysis

### Problem Description

Los alumnos de la Universidad De La Salle Bajío no tiene una forma natural de consumir su información relevante
a la comunidad. Con natural se refiere a nativo en la plataforma en donde se esté consumiendo.

### Impact

**Alumno**

El proceso de consulta e interacción con la universidad será eficaz, aumentando el nivel de comodidad del estudiante de
ser parte de la institución.

**Institución**

Se automatizarán procesos que en la actualidad significan tiempo invertido en su ejecución. El personal podrá dedicar su
tiempo a tareas menos repetitivas y aumentar la productividad de la institución en general.

### Background

Al momento del lanzamiento del proyecto para ver:

- Horario
- Calificaciones
- Créditos
- Maestros

Se necesitan los siguientes pasos:

1. Abrir navegador
2. Ir a la página de la salle
3. Ir a la página de la comunidad
4. Iniciar sesión
5. Ir a consulta académica

Al momento del lanzamiento no existía competencia como tal.

### Objective

Crear una solución móvil que sirva de intermediario entre el alumno y la institución

### Scope

miSalle será un intermediario entre el actual sistema de la universidad, y los dispositivos móviles del alumno

### Out Of Scope

Si se rompe con la relación alumno-universidad, queda fuera del alcance del proyecto

### Cost

- Recursos monetarios que cueste la insfraestructura
- Recursos humanos
- Tiempo inadvertido

### Benefit

- No hay competencia en el mercado, por lo que se podría llegar al 100% del alumnado.
- Se abre la oportunidad de colaborar con la universidad
- Abre la posibilidad de cambiar el esquema de enseñanza de la escuela

### Future

A pesar del alcance que se declaró, se ve a futuro las siguientes características:

- Detalles de créditos
- Plan de estudios
- Vista de horario por semana
- El alumno podrá ir anotando sus faltas para no tener que esperar a que se suban al sistema
- El usuario podrá ser creador de eventos y proyectos para compartir con el alumnado
- Se creará algún tipo de enlance entre los negocios cerca de la universidad, ya que son parte de la comunidad
- Se hará difusión sobre eventos organizados por la universidad
- Se ofrecerá ser un intermediario bancario entre el alumno y la universidad para pagos de colegiaturas, etc...
- Se creará un sistma de evaluación para maestros y materias, generando retroalimentación visible para los alumnos

### Functional Requirements

1. [x] El usuario inciará sesión con sus credenciales de la universidad
2. [x] El sistema mostrará un horario que sólo recorra las horas de clase del alumno, identificando cada clase con su
nombre y el del profesor
3. [x] El sistema mostrará la siguiente clase del alumno en caso de que exista una
4. [x] El sistema mostrará las calificaciones por parcial del alumno
5. [x] El sistema mostrará la cantidad de créditos culturales, sociales y deportivos que tiene el alumno
6. [x] El sistema mostrará un aviso 5 días antes del día de vencimiento de pago de colegiatura
7. [x] El sistema mostrará las faltas del alumno por materia
8. [x] El sistema mostrará el nombre, matrícula, y carrera del alumno
9. [x] El alumno podrá subir una foto a su información personal

### Non Functional Requirements

1. El sistema consumirá la información de los alumnos a través de web scrapping
2. La aplicación de consumo del alumno será móvil
3. La aplicación móvil deberá existir para Android y iOS, dándole prioridad de tiempo a Android
4. El sistema sólo permitirá el ingreso de alumnos con credenciales de instituciones pertenecientes a la
Universidad De La Salle Bajío
5. La aplicación deberá ser capaz de mostrar la información del alumno sin una conexión a internet

### Risks

#### Bloqueo de ip del scrapper por parte de La Salle

##### Descripción
Al obtener la información del sitio de La Salle por medio de scrapping, fácilmente la institución, al percatarse de la extracción de la información, puede sin ningún problema bloquear el acceso al sitio por medio de la ip.

##### Severidad
**Alta**
Es la principal fuente del sistema

##### Acción
1. En la arquitectura se observa que el scrapper estará en un nivel diferente, hospedado en Heroku. Cada 24 hrs Heroku reinicia los dynos, proporcionándole una nueva ip. En caso de que el bloqueo suceda antes, se puede reiniciar el dyno manualmente.
2. La información al ser semi-estática, se guardará en el dispositivo del usuario, para no depender del sitio de La Salle para el acceso de su información, así en cualquier evento, la interacción de los usuarios ya registrados en el sistema no se verá afectada

#### Cambio de formato en sitio web de La Salle

##### Descripción
El sistema al hacer scrapping al sitio de La Salle, depende del como la información es presentada en el buscador. Si la institución decide cambiar el esquema del html, el scrapper dejaría de funcionar efectivamente

##### Severidad
**Media**
Esto llevaría a rediseñar el scrapper para que satisfaga las necesidades del esquema html de la institución

##### Probabilidad
**Baja**
El sitio está pobremente diseñado, y al parecer fuertemente atado al cómo la información es guardada en su almacén de datos. El rediseño implica un esfuerzo enorme, que la institución no logrará a corto plazo.
También se sabe que en el primer semestre del año, la universidad analiza y distribuye el presupuesto de la institución, poniendo a trabajar el dinero en el segundo semestre. Esto nos da tiempo para crear una base de usuarios solida y para estar listos para el nuevo ingreso en Agosto

##### Acción
Diseñar el sistema de una manera que los cambios del scrapper sean en 1 sólo lugar, sin afectar la funcionalidad de todo lo demás

#### Insuficiencia de fondos ($) para mantener el sistema

##### Descripción
El equipo de trabajo actualmente no cuenta con inversionistas mayores, por lo que el proyecto se está llevando a cabo con recursos propios. Esto significa una limitada disposición de fondos para la contratación de desarrolladores y para pagar servidores

##### Severidad
**Mediana**
En el momento que la demanda económica del proyecto crezca como para no ser capaces de soportar los gastos, significa que la base de usuarios y el tráfico son constantes, consecuentemente el valor del proyecto crece y se puede buscar una manera de financiar el proyecto con bases más sólidas

##### Probabilidad
**Mediana**
El equipo de trabajo no cuenta con la experiencia necesaria para poder calcular el costo del tráfico próximo a generar.

##### Acción
1. Se utilizará el paquete de estudiante que ofrece GitHub para el desarrollo del proyecto
2. Se utilizarán los dominios proporcionados por heroku (~~~.herokuapp.com) para el scrapper y para el api
3. Se generarán ingresos con el modelo de negocio del proyecto

### High Level Design

![](img_assets/arquitectura_alto_nivel.JPG)

### Data Flow Analysis

![](img_assets/diagrama_flujo_datos.JPG)

### Screen Analysis

![](img_assets/analisis1.JPG)

![](img_assets/analisis2.JPG)

![](img_assets/analisis3.JPG)

![](img_assets/analisis4.JPG)

![](img_assets/analisis5.JPG)

![](img_assets/analisis6.JPG)

![](img_assets/analisis7.JPG)

![](img_assets/analisis8.JPG)

![](img_assets/analisis9.JPG)

## System Design

### Class Diagram

![](img_assets/diagrama_clases.JPG)

### Architecture Modules

![](img_assets/arquitectura_detalle.JPG)

### Color Palette

![](img_assets/paleta_colores.JPG)

### UI Prototype

![](img_assets/prototipo.JPG)

## API Spec

### Alumno

#### Ruta

```
/alumno
```

#### Descripción

En el siguiente endpoint se obtendrá toda la información del alumno. Esto incluye:

- Información
- Horario
- Créditos
- Periodos
- Fechas de pago

#### Método

`POST`

#### Parámetros

`{matricula: "XXXXX", password: "XXXXXX", sistema: "X"}`

#### Respuesta (200)

```
{
  "matricula": "XXX",
  "nombre": "XXXX",
  "apellido_p": "XXXX",
  "apellido_m": "XXXX",
  "email": "XXXXX",
  "usuario": {
    "matricula": "XXXX",
    "password": "XXXX",
    "sistema": 1
  },
  "campus": {
    "nombre": "XXXXXX"
  },
  "programa": {
    "nombre": "XXXXX"
  },
  "creditos": [{
    "tipo": "XXXXX",
    "necesarios": 0,
    "actuales": 0
  }, {
    "tipo": "XXXX",
    "necesarios": 0,
    "actuales": 0
  }, {
    "tipo": "XXXX",
    "necesarios": 0,
    "actuales": 0
  }],
  "clases": [{
    "dia": 1,
    "hora_inicio": 14,
    "hora_final": 16,
    "materia": {
      "nombre": "XXXX"
    },
    "profesor": {
      "nombre": "XXXXXX"
    }
  }],
  "periodos": [{
    "nombre": "XXXXX",
    "boletas": [{
      "tipo": "XXXXX",
      "materia": {
        "nombre": "XXXXX"
      },
      "profesor": {
        "nombre": "XXXXX"
      },
      "faltas": 0,
      "parciales": [{
        "numero": 1,
        "calificacion": 0.0
      }, {
        "numero": 2,
        "calificacion": 0.0
      }, {
        "numero": 3,
        "calificacion": 0.0
      }, {
        "numero": 4,
        "calificacion": 0.0
      }, {
        "numero": 5,
        "calificacion": 0.0
      }]
    }]
  }],
  "pagos": [{
    "id": 1,
    "fecha": "2017-08-11"
  }],
  "nuevo_ingreso": 0
}
```

### Créditos

#### Ruta

```
/creditos
```

#### Descripción

En el siguiente endpoint se obtendrán los créditos de un alumno

#### Método

`POST`

#### Parámetros

`{matricula: "XXXXX", password: "XXXXXX", sistema: "X"}`

#### Respuesta (200)

```
{
  "creditos": [{
    "tipo": "Solidaridad",
    "necesarios": 30,
    "actuales": 33
  }, {
    "tipo": "Cultural",
    "necesarios": 30,
    "actuales": 33
  }, {
    "tipo": "Deportivo",
    "necesarios": 30,
    "actuales": 32
  }]
}
```

### Periodos

#### Ruta

```
/periodos
```

#### Descripción

En el siguiente endpoint se obtendrán los periodos de un alumno

#### Método

`POST`

#### Parámetros

`{matricula: "XXXXX", password: "XXXXXX", sistema: "X"}`

#### Respuesta (200)

```
{
  "periodos": [{
    "nombre": "XXXXX",
    "boletas": [{
      "tipo": "XXXXX",
      "materia": {
        "nombre": "XXXXX"
      },
      "profesor": {
        "nombre": "XXXXX"
      },
      "faltas": 0,
      "parciales": [{
        "numero": 1,
        "calificacion": 0.0
      }, {
        "numero": 2,
        "calificacion": 0.0
      }, {
        "numero": 3,
        "calificacion": 0.0
      }, {
        "numero": 4,
        "calificacion": 0.0
      }, {
        "numero": 5,
        "calificacion": 0.0
      }]
    }]
  }]
}
```


# Aknowledgements

A special mention to Andrea Hernández De Alba, for her initial colaboration in the proyecto, making the UI design, the frontend and part of the development of the Android app.
