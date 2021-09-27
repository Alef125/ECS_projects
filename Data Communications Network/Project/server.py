import asyncio

from user import User
from session import Session
from tokens import UnAuthenticatedError, check_authenticated

users = {}
sessions = {}


class UserNotFound(Exception):
    pass
class SessionNotFoundError(Exception):
    pass

class ProjectProtocol(asyncio.DatagramProtocol):
    def __init__(self):
        print('STARTING SERVER')
        super().__init__()

    def connection_made(self, transport):
        self.transport = transport

    def datagram_received(self, data, addr):
        print(data, addr)
        self.process_message(data, addr)

    def process_message(self, data, addr):
        commands_pallet = {"REGISTER": self.process_register,
                    "HEARTBEAT": self.process_heartbeat,
                    "INVITE": self.process_invite,
                    "MAKE_RELAY": self.process_make_relay,
                    "ACK_RELAY": self.process_ack_relay,
                    "RELAY": self.process_relay,
                    "TERMINATE": self.process_terminate}
        check_string = (data[0:5]).decode('utf-8')
        if check_string == 'RELAY':
            self.process_relay(data[6:38], data[39:], addr)
        else:
            try:
                data = data.decode('utf-8')
                command = data.split(':')
                if command[0] in commands_pallet.keys():
                    commands_pallet[command[0]](command[1:], addr)
                else:
                    self.transport.sendto(bytes('UnknownCommand', 'utf-8'), addr)
            except UnAuthenticatedError:
                self.transport.sendto(bytes('UnAuthorized', 'utf-8'), addr)
            except SessionNotFoundError:
                self.transport.sendto(bytes('SessionNotFound', 'utf-8'), addr)
            except Exception as e:
                print('Top Level error: ' + str(e) + '\n')

    def process_register(self, args, addr):
        token = args[0]
        name = ':'.join(args[1:])
        check_authenticated(token)
        if name in users.keys():
            if users[name].token == token:
                users[name].addr = addr
            else:
                self.transport.sendto(bytes('DuplicateUserName', 'utf-8'), addr)
                return
        else:
            users[name] = User(token, name, addr)
        self.transport.sendto(bytes('Registered', 'utf-8'), addr)

    def process_heartbeat(self, args, addr):
        token = args[0]
        user = find_user_by_token(token)
        if user is None:
            return
        user.heartbeat()

    def process_invite(self, args, addr):
        user, peer = self.get_user_and_peer(args, addr)
        self.transport.sendto(to_message('START:%s' % user.get_addr_as_string()), peer.addr)
        self.transport.sendto(to_message('START:%s' % peer.get_addr_as_string()), user.addr)

    def process_make_relay(self, args, addr):
        user, peer = self.get_user_and_peer(args, addr)
        session = Session(user, peer)
        key = session.session_key
        if key in sessions.keys() and sessions[key].is_active:
            self.transport.sendto(to_message('active_session %s' % key), addr)
            return
        sessions[key] = session
        self.transport.sendto(to_message('RELREQ_FROM:%s' % user.name), peer.addr)
        self.transport.sendto(to_message('SUCCESS'), user.addr)

    def process_ack_relay(self, args, addr):
        user, peer = self.get_user_and_peer(args, addr)
        key = find_unactivated_peer_session(user, peer)
        if key in sessions.keys() and sessions[key].user2.token == user.token:
            sessions[key].is_active = True
            self.transport.sendto(to_message('RELTO:%s:%s' % (user.name, key)), peer.addr)
            self.transport.sendto(to_message('RELTO:%s:%s' % (peer.name, key)), user.addr)


    def process_relay(self, key, data, addr):
        session_key = key.decode('utf-8')
        message_body =  data
        session = sessions.get(session_key, None)
        if session is None:
            raise SessionNotFoundError
        self.transport.sendto(to_message('RELAYED:%s:' % (session_key, )) + message_body, session.get_other_address(addr))
        self.transport.sendto(to_message('RELAYED'), addr)

    def process_terminate(self, args, addr):
        token = args[0]
        session_key = args[1]
        session = sessions.get(session_key, False)
        if session.user1.token == token or session.user2.token == token:
            sessions.pop(session_key)

    def get_user_and_peer(self, args, addr):
        token = args[0]
        peer_name = ':'.join(args[1:])
        check_authenticated(token)
        user = find_user_by_token(token)
        peer = users.get(peer_name, None)
        if peer is not None and not peer.is_active():
            peer = None
        if user is None or peer is None:
            self.transport.sendto(to_message('PeerNotFound'), addr)
            raise UserNotFound
        user.heartbeat()
        return user, peer

def find_unactivated_peer_session(user, peer):
    for key, session in sessions.items():
        if session.user1.token == peer.token and session.user2.token == user.token and session.is_active == False:
            return key
    return None


def find_user_by_token(token):
    for user in users.values():
        if user.token == token:
            return user
    return None


def to_message(data):
    return bytes(data, 'utf-8')


def start_server():
    loop = asyncio.get_event_loop()
    t = loop.create_datagram_endpoint(ProjectProtocol,local_addr=('0.0.0.0',1356))
    loop.run_until_complete(t)
    loop.run_forever()


def main():
    start_server()

if __name__ == '__main__':
    main()
