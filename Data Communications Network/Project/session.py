import hashlib
import array
import random


class Session:
    def __init__(self, user1, user2):
        self.user1 = user1
        self.user2 = user2
        key_raw = [ord(a) ^ ord(b) for a, b in zip(user1.token, user2.token)]
        key_raw.extend(random.sample(range(10), 10))
        key = array.array('B', key_raw).tostring()
        self.session_key = hashlib.md5(key).hexdigest()
        self.is_active = False

    def get_other_address(self, addr):
        if self.user1.addr == addr:
            return self.user2.addr
        else:
            return self.user1.addr
