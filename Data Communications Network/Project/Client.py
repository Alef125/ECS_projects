import socket
# from time import sleep
import select

s = socket.socket(family=socket.AF_INET,  # IPv4
                  type=socket.SOCK_DGRAM)  # IPv4
# host = socket.gethostname()
host = socket.gethostbyname('localhost')
port = 12345
socket_pair = (host, port)
connecteed = False
k_wait = 0
print 'Waiting For the Receiver...'
s.setblocking(0)
while not connecteed:
    wait_message = '\r' + '.' * (k_wait + 1)
    print wait_message,
    k_wait = (k_wait + 1) % 5
    s.sendto('Ali', socket_pair)
    ready = select.select([s], [], [], 1)
    if ready[0]:
        data, client_addr_pair = s.recvfrom(65536)
        if data == 'ACK':
            connecteed = True
            print '\rDone'
'''
connected = False
print 'Waiting For the Server...'
k_wait = 0
while not connected:
    try:
        s.connect(socket_pair)
        connected = True
        print '\rConnected to Server'
    except socket.error:
        s = socket.socket(family=socket.AF_INET)
        sleep(1.5)
        wait_message = '\r' + '.' * (k_wait + 1)
        print wait_message,
        k_wait = (k_wait + 1) % 5

# Connection Messages
conn = {'ending_command': 'End',
        'ending_message': '###END###'}

received = s.recv(1024)
print received

command = raw_input('Next Message: ')

while command != conn['ending_command']:
    s.send(command)
    received = s.recv(1024)
    print received
    command = raw_input('Next Message: ')

s.send(conn['ending_message'])
s.close()'''
