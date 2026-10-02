Feature: PUT /usuarios/{_id} - Actualizar usuario
  Como un administrador del sistema,
  Quiero modificar los datos de un usuario existente,
  Para mantener actualizada la base de datos.

  Background:
    * url baseUrl
    * def generadorDatos = read('classpath:serverest/helpers/generadorDatos.js')

  Scenario: Actualizar exitosamente la informacion de un usuario existente
    * def usuarioBase = generadorDatos()
    Given path 'usuarios'
    And request usuarioBase
    When method POST
    Then status 201
    * def idUsuario = response._id

    * def usuarioActualizado = generadorDatos()
    Given path 'usuarios', idUsuario
    And request usuarioActualizado
    When method PUT
    Then status 200
    And match response.message == 'Registro alterado com sucesso'

  Scenario: Caso Alternativo - Registrar nuevo usuario cuando el ID no existe
    * def nuevoUsuario = generadorDatos()
    Given path 'usuarios', 'ID_INEXISTENTE_PUT'
    And request nuevoUsuario
    When method PUT
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'