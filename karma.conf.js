//jshint strict: false
module.exports = function(config) {
  config.set({

    basePath: './casepropods/family_connect_subscription/static',

    files: [
      'angular.min.js',
      'subscription_pod_directives.js',
      'subscription_pod_template.html',
      'test-pod.coffee',
    ],

    frameworks: ['jasmine'],

    preprocessors: {
          '**/*.coffee': ['coffee'],
        },

    browsers: ['PhantomJS'],

    reporters: ['progress'],

    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: false,
    singleRun: false,
  });
};
