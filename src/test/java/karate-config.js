function fn() {
  var config = {
    baseUrl: 'https://serverest.dev'
  };

  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);

  return config;
}