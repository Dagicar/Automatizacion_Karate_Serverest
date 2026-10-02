Feature: POST /usuarios - Registrar usuario
  Como un administrador del sistema,
  Quiero registrar nuevos usuarios en el sistema,
  Para incorporarlos a la base de datos.

  Background:
    * url baseUrl
    * def generadorDatos = read('classpath:serverest/helpers/generadorDatos.js')

  Scenario: Registrar un nuevo usuario con datos validos
    * def nuevoUsuario = generadorDatos()
    Given path 'usuarios'
    And request nuevoUsuario
    When method POST
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    And match response._id == '#string'

  Scenario: Caso Negativo - Intentar registrar usuario con correo duplicado
    * def usuario = generadorDatos()
    Given path 'usuarios'
    And request usuario
    When method POST
    Then status 201

    Given path 'usuarios'
    And request usuario
    When method POST
    Then status 400
    And match response.message == 'Este email já está sendo usado'

  Scenario: Caso Negativo - Validar campos requeridos enviando payload vacio
    Given path 'usuarios'
    And request {}
    When method POST
    Then status 400
    And match response.nome == 'nome é obrigatório'
    And match response.email == 'email é obrigatório'
    And match response.password == 'password é obrigatório'
    And match response.administrador == 'administrador é obrigatório'