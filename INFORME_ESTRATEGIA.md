# Informe de Estrategia de Automatización y Patrones de Diseño

En este documento detallo cómo estructure la solución, los criterios que tome en cuenta para diseñar las pruebas y como resolvi los desafios propios de probar contra la API de ServeRest.

## 1. Organización del Proyecto y Modularidad
Opté por separar cada operación principal en su propio archivo .feature dentro de src/test/java/serverest/users/:   
- post_usuarios.feature   
- get_usuarios.feature   
- get_usuarios_por_id.feature   
- put_usuarios_por_id.feature   
- delete_usuarios_por_id.feature

Tomé esta decisión para no tener un archivo gigante con todos los flujos mezclados, previniendo escenarios monolíticos y permitiendo ejecuciones focalizadas por funcionalidad.

## 2. Principio de Atomicidad e Independencia de Datos
Uno de los principales problemas al automatizar APIs públicas es depender de datos preexistentes o del orden en que corren los tests. Para evitar pruebas frágiles o dependencias cruzadas:  

- Ninguna prueba depende del resultado o estado generado por otra. 

- En los escenarios de consulta puntual (GET por ID), actualización (PUT) y borrado (DELETE), primero registro un usuario nuevo dentro del mismo escenario, capturo su _id generado y luego ejecuto la acción que quiero probar. 

- La prueba de filtrado por parámetro query prepara su propio registro previo para garantizar la existencia del registro en ambientes compartidos. 

- Cada escenario es autosuficiente: si se ejecuta solo o en desorden, el resultado siempre es consistente.

## 3. Generación Dinámica de Datos 
ServeRest rechaza registros con correos duplicados devolviendo un error 400 *Este email já está sendo usado*. Para no tener que cambiar correos manualmente entre ejecuciones:  

- Creé una función en JavaScript (`generadorDatos.js`) aprovechando que Karate permite invocar clases de Java de forma nativa.   

- Usé java.util.UUID para producir identificadores únicos en cada llamada (`usuario_@mail.com`).   

- Esto asegura que la suite sea idempotente y pueda ejecutarse de forma recurrente sin fallas por datos estáticos residuales.

## 4. Validación Contractual JSON 
Para verificar que el backend mantenga la estructura de datos acordada sin acoplar las aserciones a valores fijos: 

- Desacoplé el contrato del usuario a un archivo independiente (`esquemaUsuario.json`) dentro de la carpeta schemas/.

- Apliqué los marcadores difusos de Karate (#string, #array) para validar consistencia de tipos y atributos. 

- En el endpoint de listar usuarios utilicé match each response.usuarios == esquemaUsuario, asegurando que toda la colección devuelta por el backend cumpla con el formato esperado. 

## 5. Manejo de Casos Negativos y Respuestas del Servidor

- Validaciones de negocio: En el registro probé el envío de un payload vacío {} para confirmar que la API exija los campos requeridos, y el reintento con el mismo correo para verificar el mensaje de duplicado.

- Consulta de ID inexistente: En lugar de enviar un ID arbitrario que pudiera fallar por formato en el routing, el test registra un usuario, lo elimina con DELETE y luego ejecuta el GET con ese mismo ID para verificar de forma fidedigna el estado de no existencia (400 Usuário não encontrado).   

- Aserciones exactas de contrato: Dado que el backend de ServeRest devuelve sus respuestas de negocio en portugués (Usuário não encontrado, Cadastro realizado com sucesso), las aserciones de mensaje se configuraron de forma exacta respetando las respuestas reales del servidor.