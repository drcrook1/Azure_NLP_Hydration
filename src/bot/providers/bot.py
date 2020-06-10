from botbuilder.schema import Activity, ActivityTypes
from botbuilder.core import ActivityHandler, TurnContext, RecognizerResult, BotFrameworkAdapter, BotFrameworkAdapterSettings
from botbuilder.schema import ChannelAccount
import os
import asyncio

async def process_message(message_body, auth_header):
    activity = Activity().deserialize(message_body)
    response = await ADAPTER.process_activity(activity, auth_header, BOT.on_turn)
    return response

class SampleBot(ActivityHandler):

    greeting = None

    def __init__(self):
        self.greeting = "Welcome to Sample Bot!"

    async def on_members_added_activity(self, members_added: [ChannelAccount], turn_context: TurnContext):
        for member in members_added:
            if member.id != turn_context.activity.recipient.id:
                return await turn_context.send_activity(
                                    self.greeting + f"We have identified you as {member.name}")

    async def on_message_activity(self, turn_context: TurnContext):
        # First, we use the dispatch model to determine which cognitive service (LUIS or QnA) to use.
        recognizer_result = await self.recognizer.recognize(turn_context)

        # Top intent tell us which cognitive service to use.
        intent = LuisRecognizer.top_intent(recognizer_result)

        # Next, we call the dispatcher with the top intent.
        return await self._dispatch_to_top_intent(turn_context, intent, recognizer_result)

SETTINGS = BotFrameworkAdapterSettings(os.environ["SP_APP_ID"], os.environ["SP_APP_PW"])
ADAPTER = BotFrameworkAdapter(SETTINGS)
BOT = SampleBot()