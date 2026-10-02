Feature: DELETE /usuarios/{_id} - Eliminar usuario
  Como un administrador del sistema,
  Quiero dar de baja a un usuario registrado,
  Para retirarlo permanentemente del sistema.

  Background:
    * url baseUrl
    * def generadorDatos = read('classpath:serverest/helpers/generadorDatos.js')

  Scenario: Eliminar exitosamente un usuario existente
    * def usuarioAEliminar = generadorDatos()
    Given path 'usuarios'
    And request usuarioAEliminar
    When method POST
    Then status 201
    * def idUsuario = response._id

    Given path 'usuarios', idUsuario
    When method DELETE
    Then status 200
    And match response.message == 'Registro excluído com sucesso'

    Given path 'usuarios', idUsuario
    When method GET
    Then status 400
    And match response.message == 'Usuário não encontrado'

  Scenario: Caso Negativo - Intentar eliminar un usuario inexistente
    Given path 'usuarios', 'ID_INEXISTENTE_9999'
    When method DELETE
    Then status 200
    And match response.message == 'Nenhum registro excluído'