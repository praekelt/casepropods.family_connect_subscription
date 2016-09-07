from casepro.pods import Pod, PodConfig, PodPlugin


class SubscriptionPodConfig(PodConfig):
    pass


class SubscriptionPod(Pod):
    def read_data(self, params):
        pass


class SubscriptionPlugin(PodPlugin):
    name = 'casepropods.family_connect_subscription'
    label = 'family_connect_subscription_pod'
    pod_class = SubscriptionPod
    config_class = SubscriptionPodConfig
    title = 'Subscription Pod'
