function fn() {
  // Genera un identificador único para que el correo nunca se repita
  var uuid = java.util.UUID.randomUUID().toString().replace(/-/g, '').substring(0, 8);
  
  return {
    nome: 'Usuario QA ' + uuid,
    email: 'qa_' + uuid + '@correo.com',
    password: 'Password123!',
    administrador: 'true'
  };
}