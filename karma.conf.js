//jshint strict: false
module.exports = function(config) {
  config.set({

    basePath: './casepropods/family_connect_subscription/static',

    files: [
      'angular.min.js',
      'angular-animate.min.js',
      'angular-sanitize.min.js',
      'angular-mocks.js',
      'subscription_pod_template.html',
      'init.js',
      'subscription_pod_directives.js',
      'test-pod.coffee',
    ],

    frameworks: ['jasmine'],

    preprocessors: {
          '**/*.coffee': ['coffee'],
          '**/*.html': ['ng-html2js']
        },
        
    ngHtml2JsPreprocessor: {
      moduleName: 'templates'
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
