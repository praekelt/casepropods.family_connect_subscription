from casepro.cases.models import Case
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

        # Get contact idenity
        case_id = params["case_id"]
        case = Case.objects.get(pk=case_id)
        params = {
            'identity': case.contact.uuid
        }

        # Start a session with the StageBasedMessagingApiClient
        stage_based_messaging_api = StageBasedMessagingApiClient(token, url)
        data = stage_based_messaging_api.get_subscriptions(params)["results"]

        # Format and return data
        content = {"items": []}
        for subscription in data:
            message_set_id = subscription['messageset']
            message_set = stage_based_messaging_api.get_messageset(
                message_set_id)
            if message_set:
                content['items'].append({
                    "name": "Message Set", "value": message_set["short_name"]})
            content['items'].append({
                "name": "Next Sequence Number",
                "value": subscription['next_sequence_number']})
            schedule_id = subscription['schedule']
            schedule = stage_based_messaging_api.get_schedule(schedule_id)
            # TODO: figure out how to format the schedule
            content['items'].append({"name": "Schedule", "value": ""})
            content['items'].append({
                "name": "Active",
                "value": subscription['active']})
            content['items'].append({
                "name": "Completed",
                "value": subscription['completed']})
        return content


class SubscriptionPlugin(PodPlugin):
    name = 'casepropods.family_connect_subscription'
    label = 'family_connect_subscription_pod'
    pod_class = SubscriptionPod
    config_class = SubscriptionPodConfig
    title = 'Subscription Pod'
