import socket
import threading
import time


# Declaring Server
server_name = 'localhost'
server_ip = socket.gethostbyname(server_name)
server_port = 1356
server_pair = (server_ip, server_port)
server = None

# Make a Socket
sock = socket.socket(family=socket.AF_INET,   # IPv4
                     type=socket.SOCK_DGRAM)  # UDP

# MD5 hash codes as tokens:
tokens = {1: 'b90aac9d1dc573ebfbc7922e629ec62e',   # 94109205one
          2: '6a83836e228ff120881fce8f9c4e1b84'}   # 94109205two


class Peer:
    def __init__(self, ip):
        self.name = None
        self.ip = ip
        self.port = None
        self.messages = []
        self.seq_number = 0   # The Sequence number to send next packet
        self.ack_number = None  # The ACK of last correct received packet
        self.authenticated = False
        self.relay_session_key = ''
        self.is_relayed = False


peers = []
received_buffer = []
send_buffer = []  # List of [message, peer, is_ack]
exit_flag = False
active_peer = None
received_ack = False
server_answer = None
name_in_check = None


def register():
    global my_name
    my_name = raw_input('\033[0;33;0mLogin as? (Your Name): ')
    global server
    server = Peer(server_ip)
    server.name = server_name
    server.port = server_port
    sleeping_time = 1
    maximum_wait = 5
    global server_answer
    Server_Lock.acquire()
    server_answer = None
    Server_Lock.release()
    add_packet(registration_message(my_id, my_name), server, False)
    print '\033[0;34;0mRegistration Request Sent to Server:', server_ip, 'On Port:', server_port

    waiting = 0
    while server_answer is None and waiting < maximum_wait:
        time.sleep(sleeping_time)
        waiting = waiting + sleeping_time

    global exit_flag
    if server_answer is None:
        print '\033[0;34;0mServer Not Responding'
        exit_flag = True
        return

    # Registered', 'DuplicateUserName', 'UnknownCommand', 'UnAuthorized'
    print '\033[0;37;0m' + str(server_answer)

    if server_answer == 'DuplicateUserName':
        register()
    elif server_answer == 'Registered':
        pass
        # print '\033[0;34;0mListening for Any Request ...'
        # ready = select.select([sock], [], [], timeout)
        # if ready[0]:
        #     server_answer, _ = sock.recvfrom(1024)  # START message from anybody
        #     print '\033[0;37;0m' + server_answer
        #     self.heartbeat()
        #     if self.make_start(server_answer):
        #         self.get_invite_check()
        # else:
        #     print '\033[0;34;0mNo Active Chat Detected'
        #     self.invite()
    else:
        exit_flag = True

    heartbeat()


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


def tcp_encode(message, seq_number, ack_number=None):
    magic_number = '73DF'
    packet_type = '01'
    ack_flag = '01'
    ack_send = ack_number
    if ack_number is None:
        ack_flag = '00'
        ack_send = 0
    packet_length = "%0.8X" % (16 + len(message.encode('utf-8')))
    message_hex_list = [hex(ord(x))[2:] for x in message]
    message_hex = ''.join(message_hex_list)
    tcp = magic_number + packet_type + ack_flag + packet_length +\
        ("%0.8X" % seq_number) + ("%0.8X" % ack_send) + message_hex
    return tcp


def tcp_decode(tcp):
    # magic_number = tcp[0:4]  # '73DF'
    # packet_type = tcp[4:6]  # '01'
    ack_flag = tcp[6:8]  # '01' or '00'
    packet_length = 2 * int(tcp[8:16], 16)
    seq_number = int(tcp[16:24], 16)
    ack_number = int(tcp[24:32], 16)
    if ack_flag != '01':
        ack_number = None
    message = (tcp[32:packet_length]).decode('hex')
    return message, seq_number, ack_number


def add_packet(app_content, peer, is_ack):
    # Yet, We pack all the message in 1 TCP Packet
    if peer is server:
        curr_message = app_content
    else:
        content = app_content
        curr_message = tcp_encode(message=content,
                                  seq_number=peer.seq_number,
                                  ack_number=peer.ack_number)
    T_send_Lock.acquire()
    send_buffer.append([curr_message, peer, is_ack])  # Authentication ACK
    T_send_Lock.release()


def sending():
    # Stop And Wait
    sleeping_time = 0.05  # Seconds
    maximum_wait = 10   # Seconds
    global exit_flag
    while not exit_flag:
        if send_buffer:
            message_details = send_buffer[0]
            curr_message = message_details[0]
            peer = message_details[1]
            is_server = (peer is server)
            is_ack = message_details[2]
            global received_ack
            ACK_Lock.acquire()
            received_ack = False
            ACK_Lock.release()
            if is_server:
                sock.sendto(curr_message, (peer.ip, peer.port))
            else:
                if peer.ip is None or peer.port is None:
                    print '\r\033[0;34;0mServer Does not Answer'
                    exit_flag = True
                    return
                if not peer.is_relayed:
                    waiting = 0
                    while not received_ack and waiting < maximum_wait:
                        sock.sendto(curr_message, (peer.ip, peer.port))
                        if is_ack:
                            break
                        time.sleep(sleeping_time)
                        waiting = waiting + sleeping_time
                    if not is_ack and not received_ack and not is_server:
                        peer.is_relayed = True
                        sock.sendto(relaying_message(my_id, peer.name), server_pair)
                        time.sleep(2)  # If not Preparing After 1 Sec, We will have problem :))

                if peer.is_relayed:
                    waiting = 0
                    while not received_ack and waiting < maximum_wait:
                        print curr_message  # TODO
                        sock.sendto(relay_message(peer.relay_session_key, curr_message), server_pair)
                        if is_ack:
                            break
                        time.sleep(sleeping_time)
                        waiting = waiting + sleeping_time

                if not is_ack and not received_ack:
                    print '\r\033[0;34;0mYour Peer Does not Answer'
                    exit_flag = True

                # if not is_ack:
                peer.seq_number = peer.seq_number + 1

            T_send_Lock.acquire()
            del send_buffer[0]
            T_send_Lock.release()


def process_message(message, peer):
    global active_peer
    if peer is server:
        message_detailed = message.split(':')
        message_bone = message_detailed[0]
        if message_bone == 'Registered':
            pass
        elif message_bone == 'START':
            partner_ip, partner_port = make_start(message_detailed[1])
            # print '\033[0;34;0mYour Partner IP is: ', partner_ip, \
            #     'and Your Partner Session Port is: ', partner_port

            # Peer Existence is not Checked!
            if name_in_check is not None:
                new_peer = find_peer(name_in_check)
                new_peer.ip = partner_ip
                new_peer.port = partner_port
            else:
                new_peer = Peer(partner_ip)
                new_peer.port = partner_port
                peers.append(new_peer)

        elif message_bone == 'SUCCESS':
            print '\r\033[0;37;0m' + message
        elif message_bone == 'RELREQ_FROM':
            print '\r\033[0;37;0m' + message
            peer_name = message_detailed[1]
            my_peer = find_peer(peer_name)
            my_peer.is_relayed = True
            add_packet(ack_relay_message(my_id, peer_name), server, False)
        elif message_bone == 'RELTO':
            peer_name = message_detailed[1]
            my_peer = find_peer(peer_name)
            active_peer = my_peer
            my_peer.relay_session_key = message_detailed[2]
            print '\r\033[0;37;0m' + message
        elif message_bone == 'RELAYED':
            if len(message_detailed) == 3:
                peer_message = message_detailed[2]
                peer = active_peer
                relay_messages_check(peer_message, peer)
        else:
            peer_message = message  # TODO
            peer = active_peer
            relay_messages_check(peer_message, peer)
        return

    if message == '##END':
        add_packet('', peer, True)
        active_peer = None
        print '\r\033[0;34;0mYour Peer Left The Chat'
        print '\033[0;33;0mYour Command (Show/End/New):',
    else:  # Surely Packet is not only ACK
        peer.messages.append(message)
        if active_peer == peer:
            print '\r\033[0;35;0m' + message
            print '\033[0;33;0m(ESC to go out)You: ',
        else:
            print '\r\033[0;37;0mYou Have New Message From ' + peer.name
            print '\033[0;33;0mYour Command (Show/End/New): ',


def relay_messages_check(received_message, my_peer):
    message, peer_seq_num, peer_ack_num = tcp_decode(received_message)
    # peer_exist = False
    for peer in peers:
        if peer.ip == my_peer.ip and peer.port == my_peer.port:
            # peer_exist = True
            if peer.authenticated:
                if peer_ack_num is not None:
                    print 'HERE1'
                    # print 'Received ack and seq sent', peer_ack_num, peer.seq_number, message
                    if peer_ack_num == peer.seq_number:
                        print 'HERE2'
                        global received_ack
                        ACK_Lock.acquire()
                        received_ack = True
                        ACK_Lock.release()
                        # peer.seq_number = peer.seq_number + 1
                # if peer.ack_number is not None:  # It is not None Because of Authentication
                # print 'seq received/ ack expected', peer_seq_num, peer.ack_number
                if peer_seq_num == peer.ack_number + 1:
                    peer.ack_number = peer.ack_number + 1
                    # elif peer_seq_num == 0:
                    #     peer.ack_number = 0
                    if message != '':
                        print 'HERE4'
                        add_packet('', peer, True)
                        app_message = message  # Assumption!
                        process_message(app_message, peer)
                else:
                    pass
                    # print 'Received seq and ack sent', peer_seq_num, peer.ack_number
                    # print '\033[0;34;0mThere is A Mistake In Network'

            else:
                peer.authenticated = True
                print peer.name
                print peer_seq_num
                if peer.name is None:  # This is Authentication message
                    peer.name = message
                    # print 'Non Auth Seq received', peer_seq_num
                    peer.seq_number = 0
                    peer.ack_number = peer_seq_num
                    add_packet('', peer, True)  # TODO
                else:  # This is ACK of Authentication message
                    peer.ack_number = peer_seq_num
                    ACK_Lock.acquire()
                    received_ack = True
                    ACK_Lock.release()


def make_reliable(received_message):
    peer_address = received_message[1]
    peer_ip = peer_address[0]
    peer_port = peer_address[1]
    # Check Server Messages
    if peer_ip == server_ip and peer_port == server_port:
        global server_answer
        Server_Lock.acquire()
        server_answer = received_message[0]
        Server_Lock.release()
        process_message(server_answer, server)
    else:
        # Transports Packets and Produces Messages, Reverse to 'add_packet'
        message, peer_seq_num, peer_ack_num = tcp_decode(received_message[0])
        # peer_exist = False

        for peer in peers:
            if peer.ip == peer_ip and peer.port == peer_port:
                # peer_exist = True
                if peer.authenticated:
                    if peer_ack_num is not None:
                        # print 'Received ack and seq sent', peer_ack_num, peer.seq_number, message
                        if peer_ack_num == peer.seq_number:
                            global received_ack
                            ACK_Lock.acquire()
                            received_ack = True
                            ACK_Lock.release()
                            # peer.seq_number = peer.seq_number + 1
                    # if peer.ack_number is not None:  # It is not None Because of Authentication
                    # print 'seq received/ ack expected', peer_seq_num, peer.ack_number
                    if peer_seq_num == peer.ack_number + 1:
                        peer.ack_number = peer.ack_number + 1
                    # elif peer_seq_num == 0:
                    #     peer.ack_number = 0
                        if message != '':
                            add_packet('', peer, True)
                            app_message = message  # Assumption!
                            process_message(app_message, peer)
                    else:
                        pass
                        # print 'Received seq and ack sent', peer_seq_num, peer.ack_number
                        # print '\033[0;34;0mThere is A Mistake In Network'

                else:
                    peer.authenticated = True  # TODO
                    if peer.name is None:  # This is Authentication message
                        peer.name = message  # TODO
                        print 'Non Auth Seq received', peer_seq_num
                        peer.seq_number = 0
                        peer.ack_number = peer_seq_num  # TODO
                        add_packet('', peer, True)  # TODO
                    else:  # This is ACK of Authentication message
                        peer.ack_number = peer_seq_num
                        ACK_Lock.acquire()
                        received_ack = True
                        ACK_Lock.release()

        # if not peer_exist:  # impossible for a peer to not exist
        #     new_peer = Peer(peer_ip)
        #     new_peer.port = peer_port
        #     new_peer.name = message
        #     new_peer.ack_number = peer_seq_num
        #     peers.append(new_peer)
        #     add_packet('', new_peer, True)
            # T_send_Lock.acquire()
            # send_buffer.append(['', new_peer, True])  # Authentication ACK
            # T_send_Lock.release()
            # sock.sendto('ACK', peer_address)


def listening():
    while not exit_flag:
        data, client_addr_pair = sock.recvfrom(1024)
        T_listen_Lock.acquire()
        received_buffer.append([data, client_addr_pair])
        make_reliable(received_buffer[0])
        del received_buffer[0]
        T_listen_Lock.release()


def find_peer(name):
    for peer in peers:
        if peer.name == name:
            return peer
    return None


def process_command(user_command):
    if user_command == 'Show':
        names = []
        for myPeer in peers:
            if myPeer.authenticated:
                names.append(myPeer.name)
        names_str = '-'.join(names)
        prompt = '\r\033[0;33;0mWhom to Show (' + names_str + '): '
        new_command = raw_input(prompt,)
        peer = find_peer(new_command)
        if peer is None:
            print '\033[0;34;0mNo Such Peer'
        else:
            print '\033[0;34;0m*** Chatting ***'
            if peer.messages:
                for text in peer.messages:
                    print '\033[0;35;0m' + text
            else:
                print '\033[0;34;0m-No Message Yet-'
            global active_peer
            active_peer = peer

    elif user_command == 'End':
        global exit_flag
        exit_flag = True
        print '\r\033[0;34;0mHave a Nice Day :))'
    elif user_command == 'New':
        peer_name = raw_input('\033[0;33;0mEnter Your Peer Name: ')
        # peer_ip = raw_input('\033[0;33;0mEnter Your Peer IP: ')
        new_peer = Peer('')
        new_peer.name = peer_name
        global name_in_check
        name_in_check = peer_name
        # peer_port = int(raw_input('\033[0;33;0mEnter Your Peer Port: '))
        # new_peer.port = peer_port
        peers.append(new_peer)
        add_packet(invite_message(my_id, peer_name), server, False)  # INVITE:...:Partner sending to server
        time.sleep(0.1)  # Not important, only to make sure
        add_packet(my_name, new_peer, False)
        # T_send_Lock.acquire()
        # send_buffer.append([my_name, new_peer, False])
        # T_send_Lock.release()
        # sock.sendto(my_name, (peer_ip, peer_port))
        print '\033[0;34;0m*** Chatting ***'
        active_peer = new_peer
    else:
        if active_peer is None:
            print '\r\033[0;34;0mBad Command'
        else:
            if command == 'ESC':
                add_packet('##END', active_peer, False)
                # T_send_Lock.acquire()
                # send_buffer.append(['##END', active_peer, False])
                # T_send_Lock.release()
                active_peer = None
            else:
                add_packet(user_command, active_peer, False)
                # T_send_Lock.acquire()
                # send_buffer.append([user_command, active_peer, False])
                # T_send_Lock.release()
                # sock.sendto(user_command, (active_peer.ip, active_peer.port))


def heartbeat():
    add_packet(heartbeat_message(my_id), server, False)


def make_start(start_pair):
    curr_str = (start_pair[2:-1]).split(',')  # ?,?,?,?},Port --> [? ? ? ?} Port]
    partner_ip = curr_str[0] + '.' + curr_str[1] + '.' + curr_str[2] + '.' + curr_str[3][0:-1]
    partner_port = int(curr_str[4][1:])
    return partner_ip, partner_port


T_listen = threading.Thread(target=listening)
T_send = threading.Thread(target=sending)
T_listen_Lock = threading.Lock()
T_send_Lock = threading.Lock()
ACK_Lock = threading.Lock()
Server_Lock = threading.Lock()
my_id = int(raw_input('\033[0;33;0mEnter Your ID (1/2): '))
if my_id == 1:
    my_port = 11111
else:
    my_port = 22222
# my_port = raw_input('\033[0;33;0mYour Port to Listen? : ')
host = socket.gethostbyname('localhost')
socket_pair = (host, int(my_port))
sock.bind(socket_pair)
T_listen.daemon = True
T_send.daemon = True
T_listen.start()
T_send.start()
my_name = None
register()

while not exit_flag:
    if active_peer is None:
        command = raw_input('\r\033[0;33;0mYour Command (Show/End/New): ',)
    else:
        command = raw_input('\r\033[0;33;0m(ESC to go out)You: ', )
    process_command(command)
