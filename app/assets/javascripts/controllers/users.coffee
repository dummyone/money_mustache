angular.module('mustache').factory 'User', ['$resource', ($resource) ->
  $resource('/users/:userId.json', userId: '@id')
]

angular.module('mustache').factory 'Transaction', ['$resource', ($resource) ->
  $resource('/users/:userId/transactions.json', userId: '@id')
]

angular.module('mustache').controller 'UsersCtrl', ['$scope', '$http', ($scope, $http) ->
  $http.get("/users.json").success (data) ->
    $scope.users = data.users

  $scope.fetchTransactions = (user) ->
    return if user.transactions
    user.loadingTransactions = on
    $http.get("/users/#{user.id}.json").success (data) ->
      user.loadingTransactions = off
      user.transactions = data.transactions
]

angular.module('mustache').directive 'transactions', [->
  restrict: 'E'
  scope:
    data: '='
  link: (scope, element, attrs) ->
    scope.$watch 'data', (data) ->
      return unless data?
      rows = []
      total = 0

      for item in data
        total += Math.floor(item.balance*10)
        rows.push x: item.posted_at, y: total

      graph = new Rickshaw.Graph
        element: element[0]
        width: element[0].parentNode.clientWidth
        height: 200
        renderer: 'line'
        series: [
          color: 'steelblue'
          data: rows
        ]

      new Rickshaw.Graph.HoverDetail
        formatter: (series, x, y) ->
          date = new Date(x * 1000)
          pad = (n) -> if n<10 then "0#{n}" else n
          date = "<span class='date'>#{date.getFullYear()}-#{pad date.getMonth()}-#{pad date.getDate()} #{pad date.getHours()}:#{pad date.getMinutes()}</span>"
          "$#{(y/10).toFixed(2)}<br>#{date}"
        graph: graph

      graph.render()
]
