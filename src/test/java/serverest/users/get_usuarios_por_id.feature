Feature: GET /usuarios/{_id} - Buscar usuario por ID
  Como un administrador del sistema,
  Quiero buscar un usuario especifico mediante su identificador unico,
  Para obtener su informacion detallada.

  Background:
    * url baseUrl
    * def generadorDatos = read('classpath:serverest/helpers/generadorDatos.js')
    * def esquemaUsuario = read('classpath:serverest/users/schemas/esquemaUsuario.json')

  Scenario: Buscar un usuario existente por su ID
    * def usuarioPrueba = generadorDatos()
    Given path 'usuarios'
    And request usuarioPrueba
    When method POST
    Then status 201
    * def idUsuario = response._id

    Given path 'usuarios', idUsuario
    When method GET
    Then status 200
    And match response == esquemaUsuario
    And match response._id == idUsuario
    And match response.email == usuarioPrueba.email

  Scenario: Caso Negativo - Buscar un usuario con identificador inexistente
    # 1. Creamos y eliminamos un usuario para garantizar un ID valido que ya NO existe
    * def usuarioTemp = generadorDatos()
    Given path 'usuarios'
    And request usuarioTemp
    When method POST
    Then status 201
    * def idInexistente = response._id

    Given path 'usuarios', idInexistente
    When method DELETE
    Then status 200

    # 2. Consultamos el ID que sabemos con certeza que fue eliminado
    Given path 'usuarios', idInexistente
    When method GET
    Then status 400
    And match response.message == 'Usuário não encontrado'