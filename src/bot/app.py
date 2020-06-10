'''
Author: David Crook
Copyright: Microsoft 2020
'''
from quart import Quart

def create_app():
    app = Quart(__name__)

    from .apis.bot import bot
    app.register_blueprint(bot)

    return app
