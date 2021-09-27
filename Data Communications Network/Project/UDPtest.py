import socket
import select

# Declaring Server
server = 'localhost'
server_ip = socket.gethostbyname(server)
server_port = 1356
server_pair = (server_ip, server_port)

# Make a Socket
sock = socket.socket(family=socket.AF_INET,   # IPv4
                     type=socket.SOCK_DGRAM)  # UDP
# sock.setblocking(0)
timeout = 10

# MD5 hash codes as tokens:
tokens = {1: 'b90aac9d1dc573ebfbc7922e629ec62e',   # 94109205one
          2: '6a83836e228ff120881fce8f9c4e1b84'}   # 94109205two


def registration_message(user_id, name):
    message = 'REGISTER:' + tokens[user_id] + ':' + name
    return message


def heartbeat_message(user_id):
    message = 'HEARTBEAT:' + tokens[user_id]
    return message


def invite_message(sender_id, receiver_name):
    message = 'INVITE:' + tokens[sender_id] + ':' + receiver_name
    return message


def relaying_message(sender_id, receiver_name):
    message = 'MAKE_RELAY:' + tokens[sender_id] + ':' + receiver_name
    return message


def ack_relay_message(sender_id, receiver_name):
    message = 'ACK_RELAY:' + tokens[sender_id] + ':' + receiver_name
    return message


def relay_message(session_key, message_body):
    message = 'RELAY:' + session_key + ':' + message_body
    return message


class MyClient:
    def __init__(self):
        self.name = ''
        self.id = 1
        self.partner_name = ''
        self.partner_ip = ''
        self.partner_port = 0
        self.relay_session_key = ''
        self.is_relayed = False

    def register(self):
        self.name = raw_input('\033[0;33;0mEnter Your Name: ')
        self.id = int(raw_input('\033[0;33;0mEnter Your ID (1/2): '))
        sock.sendto(registration_message(self.id, self.name), server_pair)
        print '\033[0;34;0mRegistration Request Sent to Server:', server_ip, 'On Port:', server_port
        ready = select.select([sock], [], [], timeout)
        server_answer = ''
        if ready[0]:
            server_answer, _ = sock.recvfrom(1024)  # Registered', 'DuplicateUserName', 'UnknownCommand', 'UnAuthorized'
            print '\033[0;37;0m' + server_answer
        else:
            print '\033[0;34;0mServer Not Responding'
        if server_answer == 'DuplicateUserName':
            self.register()
        elif server_answer == 'Registered':
            print '\033[0;34;0mListening for Any Request ...'
            ready = select.select([sock], [], [], timeout)
            if ready[0]:
                server_answer, _ = sock.recvfrom(1024)  # START message from anybody
                print '\033[0;37;0m' + server_answer
                self.heartbeat()
                if self.make_start(server_answer):
                    self.get_invite_check()
            else:
                print '\033[0;34;0mNo Active Chat Detected'
                self.heartbeat()
                self.invite()

    def heartbeat(self):
        sock.sendto(heartbeat_message(self.id), server_pair)

    def make_start(self, start_message):
        ans_split = start_message.split(":")
        if len(ans_split) == 2 and ans_split[0] == 'START':
            curr_str = (ans_split[1][2:-1]).split(',')  # ?,?,?,?},Port --> [? ? ? ?} Port]
            self.partner_ip = curr_str[0] + '.' + curr_str[1] + '.' + curr_str[2] + '.' + curr_str[3][0:-1]
            self.partner_port = int(curr_str[4])
            print '\033[0;34;0mYour Partner IP is: ', self.partner_ip,\
                'and Your Partner Session Port is: ', self.partner_port
            return True
        return False

    def my_transfer_file(self, my_file):
        pass

    def send_message(self):
        prompt_text = '\033[0;33;0mEnter Message to ' + self.partner_name + ': '
        message = raw_input(prompt_text)
        message_detailed = message.split(':')
        if message_detailed[0] == 'SENDTEXT':
            is_file = False
        else:
            is_file = True

        if is_file:
            address = message_detailed[1]
            my_file = open(address, 'rb')
            self.my_transfer_file(my_file)
        else:
            message_to_send = message_detailed[1]
            if self.is_relayed:
                self.relay(message_to_send)
            else:
                sock.sendto(message_to_send, (self.partner_ip, self.partner_port))
                server_answer, _ = sock.recvfrom(1024)  # ACK or Maybe piggy backed message
        self.heartbeat()

    def receive_message(self):
        ready = select.select([sock], [], [], timeout)
        if ready[0]:
            server_answer, _ = sock.recvfrom(1024)  # Received message
            print '\033[0;37;0m' + server_answer
            if self.is_relayed:
                sock.sendto(relay_message(self.relay_session_key, 'OK'), server_pair)
            else:
                sock.sendto('OK', (self.partner_ip, self.partner_port))
        self.heartbeat()

    def relay_init(self):
        sock.sendto(relaying_message(self.id, self.partner_name), server_pair)
        server_answer, _ = sock.recvfrom(1024)  # SUCCESS message or PeerNotFound
        print server_answer
        if server_answer == 'SUCCESS':
            server_answer, _ = sock.recvfrom(1024)  # RELTO message
            print '\033[0;37;0m' + server_answer
            self.relay_session_key = (server_answer.split(':'))[2]
        self.heartbeat()
        self.send_message()

    def relay_receive_init(self):
        ready = select.select([sock], [], [], timeout)
        if ready[0]:
            server_answer, _ = sock.recvfrom(1024)  # RELREQ_FROM
            print '\033[0;37;0m' + server_answer
            answer_split = server_answer.split(':')
            if answer_split[0] == 'RELREQ_FROM':
                self.partner_name = answer_split[1]
                sock.sendto(ack_relay_message(self.id, self.partner_name), server_pair)
                server_answer, _ = sock.recvfrom(1024)  # RELTO message
                print server_answer
                self.relay_session_key = (server_answer.split(':'))[2]
                self.heartbeat()
                self.receive_message()
            else:
                print '\033[0;34;0mBad Partner'
        else:
            print '\033[0;34;0mNo Trying to Relay from Partner'

    def relay(self, message):
        print relay_message(self.relay_session_key, message)
        sock.sendto(relay_message(self.relay_session_key, message), server_pair)
        server_answer, _ = sock.recvfrom(1024)  # ACK or Maybe piggy backed message

    def invite_check(self):
        sock.sendto('TEST', (self.partner_ip, self.partner_port))
        partner_answer = ''
        print '\033[0;34;0mChecking Conversation ...'
        ready = select.select([sock], [], [], timeout)
        if ready[0]:
            partner_answer, _ = sock.recvfrom(1024)
            print '\033[0;37;0m' + partner_answer
        if partner_answer == 'TEST OK':
            self.send_message()
        else:
            print '\033[0;34;0mConversation has a problem. Now, trying to Make Relay ...'
            self.is_relayed = True
            self.relay_init()

    def get_invite_check(self):
        partner_answer = ''
        print '\033[0;34;0mChecking Conversation ...'
        ready = select.select([sock], [], [], timeout)
        if ready[0]:
            partner_answer, _ = sock.recvfrom(1024)
            print '\033[0;37;0m' + partner_answer
        if partner_answer == 'TEST':
            sock.sendto('TEST OK', (self.partner_ip, self.partner_port))
            self.receive_message()
        else:
            print '\033[0;34;0mConversation has a problem. Now, trying to Receive Relay ...'
            self.is_relayed = True
            self.relay_receive_init()

    def invite(self):
        self.partner_name = raw_input('\033[0;33;0mEnter the Name of Your New Partner to Chat: ')
        sock.sendto(invite_message(self.id, self.partner_name), server_pair)  # INVITE:...:Partner
        server_answer, _ = sock.recvfrom(1024)  # START message: START:{{?,?,?,?},Port}
        print '\033[0;37;0m' + server_answer
        self.heartbeat()
        if self.make_start(server_answer):
            self.invite_check()


# print server_pair
# sock.sendto('REGISTER:' + tokens[1] + ':' + 'Ali', server_pair)
# print sock.recvfrom(1024)[0]
client = MyClient()
client.register()
