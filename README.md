# ServeRest Users API - Pruebas automatizadas con Karate DSL

Suite de pruebas automatizadas para la API de Usuarios de [ServeRest](https://serverest.dev/) desarrollada con Karate DSL sobre Java 17 y Apache Maven.

## Requisitos del Entorno
* Java JDK 17 o superior.
* Apache Maven 3.9 o superior.
* Conexión a Internet (acceso a `https://serverest.dev`).

## Estructura del Framework
* `src/test/java/serverest/helpers/`: Funciones JavaScript para generación dinámica de datos de prueba.
* `src/test/java/serverest/users/schemas/`: Contratos de esquema JSON desacoplados.
* `src/test/java/serverest/users/`: Feature files independientes por cada operación CRUD solicitada.

## Ejecución de las Pruebas

Ejecutar la suite completa mediante Maven:
```bash
mvn clean test
```
Ejecutar un feature específico

- Crear usuario (POST):
```bash
mvn test -Dtest=TestRunner "-Dkarate.options=classpath:serverest/users/post_usuarios.feature"
```
- Listar usuarios (GET):
```bash
mvn test -Dtest=TestRunner "-Dkarate.options=classpath:serverest/users/get_usuarios.feature"
```
- Buscar usuario por ID (GET por ID):
```bash
mvn test -Dtest=TestRunner "-Dkarate.options=classpath:serverest/users/get_usuarios_por_id.feature"
```
- Actualizar usuario (PUT):
```bash
mvn test -Dtest=TestRunner "-Dkarate.options=classpath:serverest/users/put_usuarios_por_id.feature"
```
- Eliminar usuario (DELETE):
```bash
mvn test -Dtest=TestRunner "-Dkarate.options=classpath:serverest/users/delete_usuarios_por_id.feature"
```