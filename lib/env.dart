const bool isProduction = false;

const testConfig = {
  'baseUrl': 'http://130.61.55.229/public/api/'
};

const productionConfig = {
  'baseUrl': 'some-url.com'
};

final environment = isProduction ? productionConfig : testConfig;