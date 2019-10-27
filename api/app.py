import random

from redis import Redis
from sanic import Sanic
from sanic.response import json

from api.config import AppConfig


def create_app() -> Sanic:
    app = Sanic(
        load_env=False,
    )

    # Parse config from env and bind to application
    config = AppConfig()
    config.init_app(app)

    # Attach redis
    redis = Redis(
        host=app.config.REDIS_HOST,
        db=app.config.REDIS_DB,
    )
    app.redis = redis

    @app.route('/config')
    def get_config(request):
        return json(request.app.configuration.as_dict(mask_sensitive_fields=True))

    @app.route('/random')
    def get_random(request):
        return json({
            'message': random.random(),
        })

    return app
