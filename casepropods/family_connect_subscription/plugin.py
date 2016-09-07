from casepro.pods import Pod, PodConfig, PodPlugin
from confmodel import fields
from seed_services_client.stage_based_messaging \
    import StageBasedMessagingApiClient


class SubscriptionPodConfig(PodConfig):
    url = fields.ConfigText("URL to query for the registration data",
                            required=True)
    token = fields.ConfigText("Authentication token for registration endpoint",
                              required=True)


class SubscriptionPod(Pod):
    def read_data(self, params):
        url = self.config.url
        token = self.config.token
        stage_based_messaging_api = StageBasedMessagingApiClient(token, url)
        params = {
            'identity': "C-002"
        }
        data = stage_based_messaging_api.get_subscriptions(params)["results"]
        content = {"items": []}
        for subscription in data:
            for k in subscription:
                content['items'].append({"name": k, "value": subscription[k]})
        return content


class SubscriptionPlugin(PodPlugin):
    name = 'casepropods.family_connect_subscription'
    label = 'family_connect_subscription_pod'
    pod_class = SubscriptionPod
    config_class = SubscriptionPodConfig
    title = 'Subscription Pod'
