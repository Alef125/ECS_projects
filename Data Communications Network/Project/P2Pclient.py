import socket
import threading
import time


sock = socket.socket(family=socket.AF_INET,   # IPv4
                     type=socket.SOCK_DGRAM)  # UDP


class Peer:
    def __init__(self, ip):
        self.name = ''
        self.ip = ip
        self.port = None
        self.messages = []
        self.seq_number = 0   # The Sequence number to send next packet
        self.ack_number = None  # The ACK of last correct received packet


peers = []
received_buffer = []
send_buffer = []  # List of [message, peer, is_ack]
exit_flag = False
active_peer = None
received_ack = False


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
    content = app_content
    curr_message = tcp_encode(message=content,
                              seq_number=peer.seq_number,
                              ack_number=peer.ack_number)
    T_send_Lock.acquire()
    send_buffer.append([curr_message, peer, is_ack])  # Authentication ACK
    T_send_Lock.release()


def sending():
    # Stop And Wait
    sleeping_time = 1  # Seconds
    while not exit_flag:
        if send_buffer:
            message_details = send_buffer[0]
            curr_message = message_details[0]
            peer = message_details[1]
            is_ack = message_details[2]
            global received_ack
            ACK_Lock.acquire()
            received_ack = False
            ACK_Lock.release()
            while not received_ack:
                sock.sendto(curr_message, (peer.ip, peer.port))
                if is_ack:
                    break
                time.sleep(sleeping_time)
            peer.seq_number = peer.seq_number + 1
            T_send_Lock.acquire()
            del send_buffer[0]
            T_send_Lock.release()


def process_message(message, peer):
    if message == '##END':
        add_packet('', peer, True)
        global active_peer
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


def make_reliable(received_message):
    # Transports Packets and Produces Messages, Reverse to 'add_packet'
    message, peer_seq_num, peer_ack_num = tcp_decode(received_message[0])
    peer_address = received_message[1]
    peer_ip = peer_address[0]
    peer_port = peer_address[1]
    peer_exist = False
    for peer in peers:
        if peer.ip == peer_ip and peer.port == peer_port:
            peer_exist = True
            if peer_ack_num is not None:
                if peer_ack_num == peer.seq_number:
                    global received_ack
                    ACK_Lock.acquire()
                    received_ack = True
                    ACK_Lock.release()
            if peer.ack_number is not None:
                if peer_seq_num == peer.ack_number + 1:
                    peer.ack_number = peer.ack_number + 1
            elif peer_seq_num == 0:
                peer.ack_number = 0
            else:
                print '\033[0;34;0mThere is A Mistake In Network'
            if message != '':
                add_packet('', peer, True)
                app_message = message  # Assumption!
                process_message(app_message, peer)

    if not peer_exist:
        new_peer = Peer(peer_ip)
        new_peer.port = peer_port
        new_peer.name = message
        new_peer.ack_number = peer_seq_num
        peers.append(new_peer)
        add_packet('', new_peer, True)
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
        names = [myPeer.name for myPeer in peers]
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
        peer_ip = raw_input('\033[0;33;0mEnter Your Peer IP: ')
        new_peer = Peer(peer_ip)
        new_peer.name = peer_name
        peer_port = int(raw_input('\033[0;33;0mEnter Your Peer Port: '))
        new_peer.port = peer_port
        peers.append(new_peer)
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


T_listen = threading.Thread(target=listening)
T_send = threading.Thread(target=sending)
T_listen_Lock = threading.Lock()
T_send_Lock = threading.Lock()
ACK_Lock = threading.Lock()
my_name = raw_input('\033[0;33;0mLogin as? (Your Name): ')
my_port = raw_input('\033[0;33;0mYour Port to Listen? : ')
host = socket.gethostbyname('localhost')
socket_pair = (host, int(my_port))
sock.bind(socket_pair)
T_listen.daemon = True
T_send.daemon = True
T_listen.start()
T_send.start()

while not exit_flag:
    if active_peer is None:
        command = raw_input('\r\033[0;33;0mYour Command (Show/End/New): ',)
    else:
        command = raw_input('\r\033[0;33;0m(ESC to go out)You: ', )
    process_command(command)
