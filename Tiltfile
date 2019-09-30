# Get git info
git_commit_hash = str(local('git rev-parse HEAD'))
git_commit_message = str(local('git show -s --format=%B'))

# Build image
docker_build(
    'bsqt/api:local',
    context='.',
    build_args=dict(
        COMMIT_HASH=git_commit_hash,
        COMMIT_MESSAGE=git_commit_message,
    ),
    live_update=[
        sync('api', '/app/api'),
    ]
)

# Deploy chart
def helmfile(filename):
    watch_file('./charts')
    watch_file(filename)
    k8s_yaml(local('helmfile -f %s template' % filename))

helmfile('./helmfile.yaml')

# Proxy
k8s_resource('api', port_forwards='7071')
