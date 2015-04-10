Learning ZMQ 
---

Prerequisites

- Ruby examples use the ffi-rzmq gem
- zguide repository is [here](https://github.com/imatix/zguide)

*Basics*

Each process will setup a `ZMQ::Context` like the following:
```ruby
# defaults
context = ZMQ::Context.create

# configure number of IO threads and/or max sockets for the context
context = ZMQ::Context.create(
  :io_threads  => 4,
  :max_sockets => 2048
)
```

Create a socket within the context by specifying the socket pattern type:
```ruby
# using context from above
request_socket = context.socket(ZMQ::REQ)
```

Transports are specified via URLs like:

- `tcp://127.0.0.1:9090`
- `inproc://name`

*Tips*

- Socket communication across threads should use `inproc` or `ipc` transports.

*Request/Reply socket pattern:*

- Requester
        - Creates a `ZMQ::REQ` socket and executes `socket.connect('tcp://127.0.0.1:9090')` to connect the socket over a TCP/IP transport (port `9090`).
        - Sends a message using either [sendmsg](https://github.com/chuckremes/ffi-rzmq/blob/master/lib/ffi-rzmq/socket.rb#L211-L229), [sendmsgs](https://github.com/chuckremes/ffi-rzmq/blob/master/lib/ffi-rzmq/socket.rb#L267-L283), [send_string](https://github.com/chuckremes/ffi-rzmq/blob/master/lib/ffi-rzmq/socket.rb#L231-L247), [send_strings](https://github.com/chuckremes/ffi-rzmq/blob/master/lib/ffi-rzmq/socket.rb#L249-L265), or [send_and_close](https://github.com/chuckremes/ffi-rzmq/blob/master/lib/ffi-rzmq/socket.rb#L285-L300) (a message).
                - [socket.rb](https://github.com/chuckremes/ffi-rzmq/blob/master/lib/ffi-rzmq/socket.rb)
                - [message.rb](https://github.com/chuckremes/ffi-rzmq/blob/master/lib/ffi-rzmq/message.rb) 
  - Receive a message using either [recvmsg](https://github.com/chuckremes/ffi-rzmq/blob/master/lib/ffi-rzmq/socket.rb#L302-L322), [recvmsgs](https://github.com/chuckremes/ffi-rzmq/blob/master/lib/ffi-rzmq/socket.rb#L367-L402), [recv_multipart](https://github.com/chuckremes/ffi-rzmq/blob/master/lib/ffi-rzmq/socket.rb#L404-L425), [recv_string](https://github.com/chuckremes/ffi-rzmq/blob/master/lib/ffi-rzmq/socket.rb#L324-L346), or [recv_strings](https://github.com/chuckremes/ffi-rzmq/blob/master/lib/ffi-rzmq/socket.rb#L348-L365).
- Responder
  - Creates a `ZMQ::REP` socket and executes `socket.bind('tcp://*:9090')` to bind the the socket over a TCP/IP transport on all network interfaces and port `9090`.

*Full REQ/REP example*

*Requester (i.e. client)*
```ruby
#!/usr/bin/env ruby
require 'rubygems'
require 'ffi-rzmq'

ctx = ZMQ::Context.create

# Socket to talk to server
puts "Connecting to hello world server..."
requester = ctx.socket(ZMQ::REQ)
requester.connect("tcp://127.0.0.1:9090")

0.upto(9) do |request_nbr|
  puts "Sending request #{request_nbr}..."
  requester.send_string "Hello"

  reply = ''
  rc = requester.recv_string(reply)
  puts "Received reply #{request_nbr} (rc #{rc}): [#{reply}]"
end
```

*Responder (i.e. server)*
```ruby
#!/usr/bin/env ruby
require 'rubygems'
require 'ffi-rzmq'

ctx = ZMQ::Context.create

puts "Starting Hello World server..."

# socket to listen for clients
socket = ctx.socket(ZMQ::REP)
socket.bind("tcp://*:9090")

while true do
  # Wait for next request from client
  request = ''
  rc = socket.recv_string(request)

  puts "Received request (rc #{rc}). Data: #{request.inspect}"

  # Do some 'work'
  sleep 1

  # Send reply back to client
  socket.send_string("Earth")
end

```

