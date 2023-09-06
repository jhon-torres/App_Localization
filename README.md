# Proyecto Geolocalización de multiples usuarios en Flutter

Integrantes:
1. Lesly Herrera
1. Mayra Ñaupari
1. Camila Mier 
1. Jhon Torres

### Documentación detallada del proyecto:

#### Funcionalidad
El proyecto tiene como objetivo brindar a todos los usuarios registrados y con sesión iniciada la capacidad de acceder a la información de otros usuarios a través de un mapa interactivo. Además, se realiza un seguimiento de la geolocalización de cada usuario en tiempo real y se almacena esta información en la base de datos de Firebase conforme se desplazan. 

#### Estructura del proyecto:
Para ofrecer las funcionalidades mencionadas, la aplicación consta de tres pantallas principales:

- Pantalla de inicio de sesión, destinada a usuarios habituales.
- Pantalla de registro, diseñada para nuevos usuarios.
- Pantalla del mapa, que muestra las ubicaciones de todos los usuarios, incluyendo la del usuario que ha iniciado sesión.

##### Detalle de las pantallas
<details>
<summary>Pantalla de inicio de sesión</summary>
  Esta pantalla cuenta con dos campos de entrada de texto (TextInput) en los cuales ingresaremos nuestras credenciales de correo y contraseña. Luego, pulsaremos "LOGIN" para acceder si ya estamos registrados. En caso de no tener una cuenta, hay un botón que redirige al usuario a la pantalla de registro.
  
  En caso de no tener claro esto a continucación se puede apreciar la vista de dicha pantalla en un dispositivo:

<picture>
  <img alt="Inicio de sesión" src="https://github.com/AleBD72/Geolocation-Flutter/blob/main/Pantallas/Login.jpg?raw=true" width="250">
</picture>
  
</details>

<details>
<summary>Pantalla de registro de usuarios</summary>
  La pantalla de registro presenta tres campos de entrada de datos para el usuario. En primer lugar, se solicita ingresar un nombre de usuario único. A continuación, se requiere proporcionar una dirección de correo electrónico válida. Por último, se debe ingresar una contraseña segura. Estos tres parámetros son esenciales para crear una nueva cuenta y acceder a todas las funcionalidades de la aplicación una vez completado el proceso de registro.
  
  En caso de no tener claro lo mencionado a continucación se puede apreciar la vista de dicha pantalla en un dispositivo:

<picture>
  <img alt="Registro" src="https://github.com/AleBD72/Geolocation-Flutter/blob/main/Pantallas/Registro.jpg?raw=true" width="250">
</picture>
  
</details>

<details>
<summary>Pantalla principal (Mapa)</summary>
  La pantalla de inicio presenta una experiencia visualmente enriquecedora al mostrar la ubicación actual del usuario en un mapa de Google Maps. Además de esta información personalizada, los usuarios tienen la capacidad de visualizar la ubicación o geolocalización de otros usuarios registrados en la plataforma. Cada usuario se representa en el mapa con una marca de color azul, lo que facilita la identificación por medio del nombre de usuarios el cual se muestra al pulsar una marca especifica, y el seguimiento de las diferentes posiciones en tiempo real. Esta característica permite a los usuarios interactuar y compartir ubicaciones de manera eficiente dentro de la aplicación.
  
  En caso de no tener claro lo mencionado a continucación se puede apreciar la vista de dicha pantalla en un dispositivo:

<picture>
  <img alt="Inicio 1" src="https://github.com/AleBD72/Geolocation-Flutter/blob/main/Pantallas/Inicio.jpg?raw=true" width="250">
</picture>
<picture>
  <img alt="Inicio 2" src="https://github.com/AleBD72/Geolocation-Flutter/blob/main/Pantallas/Inicio%202.jpg?raw=true" width="250">
</picture>
  
</details>

#### Guardado de la información en la base de datos de Firebase:
Finalmente, la aplicación realiza el almacenamiento de información en Firebase a través de Firestore y Firebase Authentication. Dentro de estas bases de datos, se guardan detalles como la dirección de correo, la ubicación (longitud y latitud), el UID del usuario y su nombre de usuario. Firestore se actualiza automáticamente a medida que el usuario se desplaza, y la información de cada usuario se almacena en una colección de Firestore llamada "locations". En esta colección, se encuentran los siguientes parámetros: Nombre, correo electrónico, latitud, longitud y nombre de usuario.

Evidencia del registro de información:
<picture>
  <img alt="Firebase 1" src="https://github.com/AleBD72/Geolocation-Flutter/blob/main/Pantallas/Captura%20de%20pantalla%202023-09-06%20122921.png?raw=true">
</picture>

<picture>
  <img alt="Firebase 2" src="https://github.com/AleBD72/Geolocation-Flutter/blob/main/Pantallas/Captura%20de%20pantalla%202023-09-06%20123601.png?raw=true">
</picture>

