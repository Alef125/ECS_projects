access_tokens = ['b90aac9d1dc573ebfbc7922e629ec62e', '6a83836e228ff120881fce8f9c4e1b84']


class UnAuthenticatedError(Exception):
    pass


def check_authenticated(token):
    if token not in access_tokens:
        raise UnAuthenticatedError
