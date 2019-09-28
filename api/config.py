import os
from typing import Union

from sanic import Sanic


class Field:
    value = Nones

    def __init__(
        self, *,
        required: bool = False, default=None,
        sensitive: bool = False, doc: str = None,
    ):
        if required and default is not None:
            raise ValueError(
                'Only one of "required" or "default" can be provided'
            )

        if not doc:
            raise ValueError('Doc string must be provided')

        self.required = required
        self.default = default
        self.sensitive = sensitive
        self.doc = doc

    def parse(self, name: str, value: Union[str, None]):
        if not value:
            if self.required:
                raise ValueError(f'Field: {name} is required')
            else:
                self.value = self.default
        else:
            self.value = value


class BaseConfig:
    def __init__(self, app: Sanic = None):
        fields = self._get_fields()
        for name, field in fields.items():
            field.parse(name, os.environ.get(name, None))

        if app:
            self.init_app(app)

    def init_app(self, app: Sanic):
        app.configuration = self
        app.config.update(app.configuration.as_dict(
            mask_sensitive_fields=False,
        ))

    def _get_fields(self) -> dict:
        return {
            name: getattr(self, name) for name in dir(self)
            if isinstance(getattr(self, name), Field)
        }

    def as_dict(self, mask_sensitive_fields: bool = False) -> dict:
        fields = self._get_fields()
        return {
            name: '*****'
            if mask_sensitive_fields and field.sensitive else field.value
            for name, field in fields.items()
        }


class AppConfig(BaseConfig):
    # Application config vars
    COMMIT_HASH = Field(
        required=True,
        doc='Git commit sha associated with image',
    )
    COMMIT_MESSAGE = Field(
        required=True,
        doc='Git commit message associated with image',
    )
