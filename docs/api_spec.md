# Api Spec

## Obtener anuncios

En esta ruta el cliente obtendrá una serie de anuncios para mostrar

*Método*
`POST`

*Ruta*
`/anuncios`

*Parámetros*
`null`

*Respuesta*
```
{
  anuncios: [{
              campaign_id: <integer>,
              ruta_imagen: <string>,
              destino_click: <string>
             }]
}
```

## Registrar click

En esta ruta se registrará cuando se realizó un click a un anuncio

*Método*
`POST`

*Ruta*
`/campaign/:id/click/:matricula`

*Parámetros*
`null`

*Respuesta*
status 200
`null`

## Registrar alumno

En esta ruta se obtendrá toda la información del alumno por primera vez, registrándolo en el sistema

*Método*
`POST`

*Ruta*
`/alumno`

*Parámetros*
`{ matricula: <string>, password: <string> }`

*Respuesta*
```
  {
    matricula: <string>,
    nombre: <string>,
    apellido_p: <string>,
    apellido_m: <string>,
    usuario: {
      matricula: <string>,
      password: <string>
    },
    campus: {nombre: <string>},
    programa: {nombre: <string>},
    creditos: [{
      tipo: <string>,
      necesarios: <string>,
      actuales: <string>
    }],
    clases: [{
      dia: <integer>,
      hora_inicio: <integer>,
      hora_final: <integer>,
      materia: {nombre: <string>},
      profesor: {nombre: <string>}
    }],
    periodos: [{
      mes_inicio: <integer>,
      mes_final: 6,
      year: <integer>,
      boletas: [{
        tipo: <string>,
        materia: {
          nombre: <string>,
        },
        profesor: {
          nombre: <string>
        },
        faltas: <integer>,
        parciales: [{
          numero: <integer>,
          calificacion: <integer>
        }]
      }],
  }]
}
```
