from sanic import Sanic
from sanic.response import json

from api.config import AppConfig


def create_app():
    app = Sanic(
        load_env=False,
    )

    # Parse config from env and bind to application
    config = AppConfig()
    config.init_app(app)

    @app.route('/config')
    def get_config(request):
        return json(request.app.configuration.as_dict(mask_sensitive_fields=True))

    return app
