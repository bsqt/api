from sanic import Sanic
from sanic.response import json
import random
from api.config import AppConfig
from redis import Redis

def create_app():
    app = Sanic(
        load_env=False,
    )

    # Parse config from env and bind to application
    config = AppConfig()
    config.init_app(app)

    # Attach redis
    redis = Redis(
        host=app.config.REDIS_HOST,
        password=app.config.REDIS_PASSWORD,
        db=app.config.REDIS_DATABASE,
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
