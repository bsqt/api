import os


def main():
    commit_hash = os.environ.get('COMMIT_HASH')
    commit_message = os.environ.get('COMMIT_MESSAGE')

    print(f'COMMIT_HASH={commit_hash}')
    print(f'COMMIT_MESSAGE={commit_message}')


main()
