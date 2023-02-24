# TALLERES RUIZ
Proyecto de desarrollo de una aplicación compuesta por un **back** que desarrolla una API-REST de gestión de un taller de automoción, y un **front** para móvil que consume dicha API. En esta, 
tendremos la posibilidad de crear un nuevo usuario con rol CLIENTE, además de loguearnos para acceder a las funcionalidades de la aplicaicón. Tendremos dos vías de acceso:
- **Rol CLIENTE (cliente/cliente)**: Podrá ver su perfil, editar su información, contraseña y avatar, ver su última o próxima cita, el listado de citas histórico, pedir una nueva cita, y 
  modificar una mientras esté en estado de trámite o aceptada. También podrá mantener un chat con el mecánico de su cita mediante mensajes o envío de fichero. 
- **Rol ADMIN (admin/admin) y MEC (mec/mec)**: Se corresponde con el dueño del taller y/o a un mecánico del mismo. Al igual que antes, estos podrán ver su perfil, editar su información, ver 
  los listados de citas, clientes y mecánicos, acceder a la información de las citas y utilizar el chat de la misma, aunque sólo podrá el mecánico que tenga asignado la cita, y, como ADMIN, se
  podrá crear un nuevo ADMIN/MEC o un MEC.
- **Contraseñas**: Por facilidad en el uso de la aplicación, a la hora de crear una nueva contraseña, al tener validación de seguridad, las características de la misma
  se definirán por tener, mínimo 6 caracteres y máximo 12, 1 minúscula, 1 mayúscula, 1 dígito y 1 caracter especial, por ejemplo **1aA_aa**.

## Tecnología y lenguaje utilizado:
Para el desarrollo de la aplicación, se han utilizado los siguientes elementos:
- **Spring Boot** como framework para el desarrollo back de la API-REST. El proyecto de Spring se ha desarrollado en su versión 2.7.8.
- **Java** para el desarrollo del código que atiende las peticiones a la API. Se ha desarrollado en la versión 17.0.5 2022-10-18 LTS.
- **PostgreSQL** para la gestión de la base de datos.
- **pgAdmin4** como sistema gestor de base de datos.
- **JPQL** para las consultas a la base de datos.
- **Flutter** como framework para el desarrollo front que consume la API-REST. Esta parte se ha desarrollado con su versión 3.8.0-12.0.pre.12.
- **Dart** para el desarrollo del código de Flutter. El código se ha desarrollado en la versión 3.0.0-228.0.dev del lenguaje.
- **Docker** para montar el contenedor de Spring Boot y PostgreSQL.

## Entorno de desarrollo y ejecución:
Para el desarrollo del proyecto, se ha utilizado el entorno de desarrollo **IntelliJ IDEA** para el back, y **Visual Studio Code** para el front. Para ejecutar el proyecto deberemos 
seguir los siguiente pasos en este orden:
- **Levantar contenedor docker**: Ejecutamos **IntelliJ IDEA** en modo administrador, abrimos la carpeta **spring**, seleccionamos la carpeta **talleres-ruiz**. Una vez se abra el
  proyecto en el entorno, en el menú inferior, seleccionamos **Terminal**, y escribimos **docker-compose up -d**. Con esto levantaremos el contenedor de docker que nos permite, cuando
  ejecutemos el proyecto, acceder tanto a la base de datos en PostgreSQL, como a las peticiones de la API-REST, como a pgAdmin4 para hacer consultas.
- **Ejecución del proyecto spring**: Trar levantar el contenedor, nos quedamos en **IntelliJ IDEA**, y, en la barra superior, en la parte derecha, en los primeros iconos, seleccionamos
  sobre **Current File**, y luego **Edit Configuration**. Al aparecer la nueva ventana, pulsamos, en el menú superior, en el icono **+**, en el desplegable, seleccionamos **Maven**, y 
  en la opción **Run**, en **Command line**, escribimos **spring-boot:run -Dspring-boot.run.fork=false** y lo seleccionamos en el menú. Si pusiéramos solo **spring-boot:run**, podríamos 
  tener problemas con el UTF-8 y mostrarse los caracteres como las tildes o la "ñ" mal. Pulsamos en **Aplicar** y **Aceptar**. Ahora solo tendremos que pulsar el icono de **Play** junto 
  a **talleres-ruiz spring-boot:run**, y, una vez finalice la ejecución en consola, tendremos el proyecto ejecutado y accesible desde la dirección **http://localhost:8080/** como ruta raíz.
- **Ejecución del proyecto flutter**: Partiendo de la base de que tendremos instalado Flutter en nuestro equipo, una vez ejecutado el proyecto de **spring**, este paso podemos realizarlo 
  tanto en **Visual Studio Code** como en el **terminal** que utilicemos. Si estamos en **VSC**, abrimos la carpeta del proyecto de **flutter**, luego **talleresruiz**, y esta es la que 
  abrimos. Si lo hicieramos en el terminal, tendríamos que buscar este directorio. Una vez abierto, en **VSC** tendremos que abrir un terminal, que podremos hacerlo en el menú superior, 
  pulsando en **Terminal**, y luego **Nuevo terminal**. Ahora, al igual que si estamos directamente en el terminal, tenemos dos posibilidades, o bien ejecutar en una ventana, o usamos un 
  emulador. Es posible que previamente tengamos que ejecutar el comando **flutter pub get** para traer las dependencias si no lo ha hecho automáticamente.
- **Ejecución en ventana**: Para ejecutar en ventana, lo primero que tendremos que hacer es ir a la carpeta **/lib/config** y entramos en el archivo **constantes.dart**. Aquí, tendremos que 
  descomentar la línea 2: **const baseUrl = 'http://localhost:8080';**, y comentar la 1. Por último tendremos que poner en el terminal que teníamos abierto, el comando **flutter run -d windows**.
  Si eligiéramos esta opción, no podremos subir ficheros ni cambiar de avatar de los usuarios porque el plugin no funciona en modo ventana, sólo en emuladores.
- **Ejecución en emulador iOS**: Al igual que antes, deberemos descomentar la línea 2: **const baseUrl = 'http://localhost:8080';** y comentar la 1. Tras ello, tendremos que abrir el emulador, 
  y cuando cargue, escribiremos en el terminal el comando **flutter run**.
- **Ejecución en emulador Android**: Por último, para este caso, deberemos descomentar la línea 1: **const baseUrl = 'http://10.0.2.2:8080';** y comentar la 2. Tras ello, tendremos que abrir 
  el emulador, y cuando cargue, escribiremos en el terminal el comando **flutter run**.

## Pruebas:
Para poder probar la API, tendremos varias vías:
- **Documentación del proyecto en Swagger**: Accederemos a través de la ruta **http://localhost:8080/swagger-ui/index.html**. Aquí, podremos probar todos los endpoints
  disponibles en la API, y ver ejemplos de retorno.
- **Aplicación de Postman**: Dentro del proyecto de **spring**, se encuentra el archivo **TalleresRuiz.postman_collection.json**. Este archivo, podremos importarlo en las colecciones de 
  Postman, en el que hay preparadas una serie de peticiones a todos los posibles métodos de la API. En las peticiones POST y PUT, cuando la seleccionemos, al pulsar en **Body**, podremos
  indicar el cuerpo que se envía en la petición para crear o modificar algún recurso, en formato JSON.
- **Acceso a la base de datos**: Podremos acceder al sistema gestor de base de datos **pgAdmin4** a través de la ruta **http://localhost:5050**, siempre y cuando hayamos levantado el contenedor
  de docker. Una vez dentro, para loguearnos, usaremos **usuario: admin@admin.com / contraseña: root**. Ahora, una vez dentro, para registrar el servidor de la base de datos, pulsamos con botón
  derecho en **Servers**, y pulsamos en **Register - Server...**. En la nueva ventana, en la pestaña seleccionada **General**, escibimos en el campo **Name** el nombre que va a tener, en nuestro
  caso, va a ser **taller**. Ahora, pasamos a la pestaña **Connection**, y en el campo **Host name/address** escribimos **db**, que es el nombre que le indicamos en el docker-compose que va a 
  tener la base de datos. El **port** lo dejamos en **5432**, y para guardar el usuario, ponemos en el campo **username: user** y en **password: password**, de esta manera, podremo acceder a la 
  base de datos desde pgAdmin.
- **Aplicación de Flutter**: Una vez tengamos ejecutada la aplicación en Flutter, al principio, sólo podremos crear un nuevo usuario de tipo **CLIENTE**, o loguearnos. Cuando nos logueemos,
  podremos acceder a las distintas peticiones gestionadas en la API-REST, aunque tendremos acceso a unas u otras en función de cual sea el rol que tengamos en el usuarios. Para poder probar
  todos los roles (**ADMIN, MEC, CLIENTE**), tendremos los usuario/contraseña: **admin/admin, mec/mec, cliente/cliente**. Con cada uno, podremos acceder a los endpoints disponibles según el rol
  del usuario.

## Organización del proyecto:
En la carpeta principal nos encontramos diferentes elementos a tener en cuenta:
- **docs**: Tendremos el **diagrama de clases** desarrollado en draw.io, así como la documentación generada. Tendremos el **enunciado** del desarrollo del proyecto, las **historias de usuario** 
  del desarrollo de la API-REST y el **plan de empresa** con vistas al desarrollo final del proyecto.
- **flutter**: En esta carpeta se encuentra todo el código fuente utilizado en el desarrollo front de **Flutter**. En la carpeta **lib** se encuentra todo el código fuente de la aplicación front.
- **spring**: Aquí tendremos el código fuente usado para el desarrollo back de **Spring**. Además, tendremos también el archivo **TalleresRuiz.postman_collection.json**, que es la colección de 
  Postman, que podremos importar en dicho programa, y que nos permitirá acceder a los distintos endpoints de la API para probar todas sus funcionalidades. Por último, en la carpeta **src**, se
  aloja todo el código fuente del desarrollo.

## Rutas disponibles según roles:
### Cualquier usuario no logueado:
#### User:
- **POST: http://localhost:8080/noauth/user/register**: Crear un nuevo usuaro de tipo cliente.
- **POST: http://localhost:8080/noauth/user/login**: Hacer login en la aplicación.

### Usuarios logueados con rol CLIENTE:
#### Cliente:
- **GET: http://localhost:8080/auth/cliente/me**: Obtener los datos del cliente logueado.
- **GET: http://localhost:8080/auth/cliente/me/citas**: Obtener el listado histórico de las citas del cliente logueado.
- **PUT: http://localhost:8080/auth/cliente/me**: Modificar los datos de usuario y cliente del usuario logueado.
- **DELETE: http://localhost:8080/auth/cliente/me**: Dar de baja al cliente logueado, en este caso, lo desactiva en caso de tener citas asociadas, o lo elimina si no.

#### Cita:
- **POST: http://localhost:8080/auth/cita/cliente**: Crear una nueva cita desde la vista de CLIENTE.
- **PUT: http://localhost:8080/auth/cita/{id}/cliente**: Modificar una cita pedida desde la vista CLIENTE, pasándole el **id** de la cita.
- **DELETE: http://localhost:8080/auth/cita/{id}/cliente**: Cancelar una de las citas del cliente, siendo esta la que se indique por su **id**.

### Usuarios logueados con rol ADMIN:
#### Mecánico:
- **GET: http://localhost:8080/auth/mecanico/{id}**: Obtener los detalles de un admin/mecánico.
- **POST: http://localhost:8080/auth/mecanico/admin**: Crear un nuevo usuario con rol ADMIN y MEC.
- **POST: http://localhost:8080/auth/mecanico/mec**: Crear un nuevo usuario con rol MEC.
- **PUT: http://localhost:8080/auth/mecanico/{id}**: Modificar los datos de un usuario con rol ADMIN o MEC, buscado por su **id**.
- **DELETE: http://localhost:8080/auth/mecanico/{id}**: Dar de baja a un usuario con rol ADMIN o MEC, buscado por su **id**. No lo elimina, si no que lo desactiva.

#### Cliente:
- **DELETE: http://localhost:8080/auth/cliente/{id}**: Dar de baja a un usuario con rol CLIENTE, buscado por su **id**. Si tiene alguna cita asociada, lo desactiva, y si no, lo elimina.

### Usuarios logueados con rol ADMIN o MEC:
#### Mecánico:
- **GET: http://localhost:8080/auth/mecanico/**: Obtener el listado completo de mecánicos.
- **GET: http://localhost:8080/auth/mecanico/me**: Obtener los datos del admin/mecánico logueado.
- **POST: http://localhost:8080/auth/cita/mecanico/me**: Crear una nueva cita desde la vista de ADMIN/MEC.
- **PUT: http://localhost:8080/auth/cita/mecanico/{id}**: Modificar los datos de una cita desde la vista de ADMIN/MEC, buscando la cita por su **id**.

#### Cliente:
- **GET: http://localhost:8080/auth/cliente/**: Obtener el listado completo de clientes.
- **GET: http://localhost:8080/auth/cliente/{id}**: Obtener los detalles de un clientes, buscado por su **id**.

#### Cita:
- **GET: http://localhost:8080/auth/cita/**: Obtener el listado completo de citas.
- **DELETE: http://localhost:8080/auth/cita/{id}**: Cancelar una cita desde la vista ADMIN/MEC.


### Usuarios logueados con cualquier rol:
#### User:
- **PUT: http://localhost:8080/auth/user/changePsw**: Modificar la contraseña del usuario logueado.
- **POST: http://localhost:8080/auth/user/avatar**: Modificar imagen de perfil del avatar del usuario logueado.

#### Cita:
- **GET: http://localhost:8080/auth/cita/{id}**: Obtener los detalles de una cita, buscada por su **id**.
- **POST: http://localhost:8080/auth/cita/{id}/mensaje**: Agregar un comentario a una cita, buscada por su **id**.
- **POST: http://localhost:8080/auth/cita/{id}/fichero**: Subir un fichero a una cita perteneciente al usuario logueado, buscada la cita por su **id**.
- **DELETE: http://localhost:8080/auth/cita/{idC}/adjunto/{idF}**: Eliminar un fichero, buscado por su ID (**idF**), de una cita, buscada por su ID (**idC**).

## Aspectos a desarrollar en el futuro:
- **Validación**: Tiene que mejorarse el aspecto de la validación de los formularios de editar, en concreto, los de editar usuario, ya que a la hora de modificar,
  como se usa el mismo DTO que para crear, se validan campos como la matrícula del vehículo o el email que tienen que ser únicos. Es por ello que como le paso un 
  email y una matrícula existentes por el mismo usuario que estoy modificando da error y te pide que lo cambies, por ello lo he deshabilitado a expensas de
  conseguir solucionarlo sin necesidad de crear un nuevo DTO.
- **Front Angular**: Desarrollo de un front en Angular para la parte de la aplicación web.
- **Servicios y recambios**: En la vista de mecánico, cuando se acceda a la creación o edición de la cita, se podrán seleccionar los distintos servicios y recambios 
  a aplicar dentro de la cita, así como gestionar los mismos con sus propias entidades en las que se recojan los precios, tiempos de empleo en los servicios, etc.
- **Cambios en entidades**: Con el desarrollo del futuro proyecto, tendrá más sentido que ahora la división entre cliente y mecánico, ya que, ahora, apenas hay
  diferencias entre las entidades, pero más adelante, el cliente podrá seleccionar la marca y modelo de su vehículo a través de una entidad Vehículo que guarde
  en la base de datos una colección de vehículos distintos. Por su parte, el mecánico tendrá también asociada una entidad Puesto que se caracterizará por el
  puesto que tiene dentro de la empresa, su sueldo, etc., para poder gestionar la plantilla de forma más cómoda, así como otros atributos característicos de un empleado.
- **Página de inicio**: En la página de inicio, tendremos información acerca de la empresa.
