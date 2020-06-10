from quart import Blueprint, request, Response
import simplejson
from ..providers import bot as botp

bot = Blueprint("bot", __name__, url_prefix="/api/v1/bot")

@bot.route("messages", methods=["POST"])
async def messages():
    """
    API entry point for the bot.
    """
    body = request.get_json()
    auth_header = request.headers["Authorization"] if "Authorization" in request.headers else ""
    print(f"body: {body}")
    print(f"auth_header: {auth_header}")
    response = await botp.process_message(body, auth_header)
    return simplejson.dumps(body, ignore_nan=True), 200