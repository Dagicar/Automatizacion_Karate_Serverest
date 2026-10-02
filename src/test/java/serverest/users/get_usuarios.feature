Feature: GET /usuarios - Listar usuarios
  Como un administrador del sistema,
  Quiero poder consultar todos los usuarios registrados,
  Para validar el listado y la estructura de los datos.

  Background:
    * url baseUrl
    * def esquemaUsuario = read('classpath:serverest/users/schemas/esquemaUsuario.json')

  Scenario: Listar todos los usuarios exitosamente
    Given path 'usuarios'
    When method GET
    Then status 200
    And match response.quantidade == '#number'
    And match response.usuarios == '#array'
    And match each response.usuarios == esquemaUsuario

  Scenario: Filtrar usuarios existentes por query parameter
    Given path 'usuarios'
    And param administrador = 'true'
    When method GET
    Then status 200
    And match response.quantidade == '#number'
    And match each response.usuarios contains { administrador: 'true' }