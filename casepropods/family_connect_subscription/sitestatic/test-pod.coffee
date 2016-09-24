# Unit tests for our Angular directives

describe('directives:', () ->
  $compile = null
  $rootScope = null
  $templateCache = null
  $q = null
  $filter = null

  beforeEach(() ->
    module('templates')
    module('cases')
    module('templates')

    inject((_$compile_, _$rootScope_, _$templateCache_, _$q_, _$filter_) ->
      $compile = _$compile_
      $rootScope = _$rootScope_
      $templateCache = _$templateCache_
      $q = _$q_
      $filter = _$filter_
    )
  )
  describe('subscriptionPod', () ->
    $rootScope = null
    $compile = null

    beforeEach(inject((_$rootScope_, _$compile_) ->
      $rootScope = _$rootScope_
      $compile = _$compile_

      $rootScope.podConfig = {
            label: 'family_connect_subscription_pod',
            title: 'Subscription Information',
            url: 'http://localhost:8080/api/v1/',
            token: 'a1f16bcb6533ce2cff98e381791bdac65583b343',
        }

      $rootScope.podData = {
        items: []
      }

      $rootScope.status = 'idle'
      $rootScope.trigger = ->
    ))

    it('should draw the pod title', () ->
      $rootScope.podConfig.title = 'Subscription Information'

      el = $compile('<subscription-pod/>')($rootScope)[0]
      $rootScope.$digest()
      
      console.log(el)
      expect(el.querySelector('.pod-title').textContent).toContain(
        'Subscription Information')
    )

    it('should draw when there are no subscriptions', ->
      $rootScope.podData = {
        items: [{
          name: 'No subscriptions', value: ''
        }]
      }

      el = $compile('<subscriptions-pod/>')($rootScope)[0]
      $rootScope.$digest()

      item1 = el.querySelector('.pod-item:nth-child(1)')

      expect(item1.querySelector('.pod-item-name').textContent)
        .toContain('No subscriptions')

      expect(item1.querySelector('.pod-item-value').textContent)
        .toContain('')
    )

    it('should draw when there is an error', ->
      $rootScope.podData = {
        items: [{
          name: 'Error', value: 'Bad Request'
        }]
      }

      el = $compile('<subscriptions-pod/>')($rootScope)[0]
      $rootScope.$digest()

      item1 = el.querySelector('.pod-item:nth-child(1)')

      expect(item1.querySelector('.pod-item-name').textContent)
        .toContain('Error')

      expect(item1.querySelector('.pod-item-value').textContent)
        .toContain('Bad Request')
    )

    it('should draw when there are subscriptions', ->
      $rootScope.podData = {
        items: [{
          rows: [{
            name: 'Message Set', value: 'test_set'
          }, {
            name: 'Next Sequence Number', value: 1
          }, {
            name: 'Schedule', value: 'At 08:00 every Monday and Tuesday'
          }, {
            name: 'Active', value: True
          }, {
            name: 'Completed', value: False
          }]
        }]
      }

      el = $compile('<subscriptions-pod/>')($rootScope)[0]
      $rootScope.$digest()

      item1 = el.querySelector('.pod-item:nth-child(1)')
      item2 = el.querySelector('.pod-item:nth-child(2)')
      item3 = el.querySelector('.pod-item:nth-child(3)')
      item4 = el.querySelector('.pod-item:nth-child(4)')
      item5 = el.querySelector('.pod-item:nth-child(5)')

      expect(item1.querySelector('.pod-item-name').textContent)
        .toContain('Message Set')

      expect(item1.querySelector('.pod-item-value').textContent)
        .toContain('test_set')

      expect(item2.querySelector('.pod-item-name').textContent)
        .toContain('Next Sequence Number')

      expect(item2.querySelector('.pod-item-value').textContent)
        .toContain('1')

      expect(item3.querySelector('.pod-item-name').textContent)
        .toContain('Schedule')

      expect(item3.querySelector('.pod-item-value').textContent)
        .toContain('At 08:00 every Monday and Tuesday')

      expect(item4.querySelector('.pod-item-name').textContent)
        .toContain('Active')

      expect(item4.querySelector('.pod-item-value').textContent)
        .toContain('True')

      expect(item5.querySelector('.pod-item-name').textContent)
        .toContain('Completed')

      expect(item5.querySelector('.pod-item-value').textContent)
        .toContain('False')
    )
    

    it('should draw whether it is loading', () ->
      $rootScope.status = 'loading'

      el = $compile('<subscription-pod/>')($rootScope)[0]
      $rootScope.$digest()

      expect(el.textContent).toMatch('Loading')
    )

    it('should draw whether loading has failed', () ->
      $rootScope.status = 'loading_failed'

      el = $compile('<subscription-pod/>')($rootScope)[0]
      $rootScope.$digest()

      expect(el.textContent).toMatch('Could not load')
    )
  )
)
