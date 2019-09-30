# bsqt-api

## Run

Normal:
```bash
garden dev --logger-type=basic --skip-tests
```

Hot reload:
```bash
garden dev --logger-type=basic --hot-reload="*" --skip-tests
```

NOTE: Ctrl+C won't *undeploy* application. In order to stop application you need
to either run:
```bash
garden delete service bsqt-api --logger-type=basic
```

Or:
```bash
garden delete env --logger-type=basic
```

## Logs
```bash
garden logs --logger-type=basic --follow
```

## Clean up
```bash
garden delete env --logger-type=basic
```
