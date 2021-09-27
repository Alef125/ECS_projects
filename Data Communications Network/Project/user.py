import time


class User:
    def __init__(self, token, name, addr):
        self.name = name
        self.token = token
        self.last_updated = time.time()
        self.addr = addr
        self.sessions = []

    def is_active(self):
        return self.last_updated > time.time() - 120

    def add_session(self, session_key):
        self.sessions.append(session_key)

    def heartbeat(self):
        self.last_updated = time.time()

    def get_addr_as_string(self):
        ip = ','.join(self.addr[0].split('.'))
        port = self.addr[1]
        return '{{%s}, %d}' % (ip, port)
