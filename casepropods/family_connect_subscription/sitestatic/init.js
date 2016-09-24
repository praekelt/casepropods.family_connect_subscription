angular.module('cases.directives', []);
angular.module('cases.controllers', [])
  .controller('PodController', ['$q', '$scope', function($q, $scope) {
    $scope.init = function (podConfig) {
      $scope.podConfig = podConfig
      $scope.status = 'loading'

      $scope.update()
        .then(function(){$scope.status = 'idle'})
    }
  }]);
angular.module('cases', [
  'cases.directives',
  'cases.controllers'
]);
