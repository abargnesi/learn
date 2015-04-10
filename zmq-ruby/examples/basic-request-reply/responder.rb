require 'ffi-rzmq'

# Does not address:
# - message send and receive timeouts
# - signal handling

ctx = ZMQ::Context.create
responder_socket = ctx.socket(ZMQ::REP)
rc = responder_socket.bind('tcp://*:9090')

# check result code of creating socket; fail if zero
if rc == -1
  # check errno
  raise "Error (#{ZMQ::Util.errno}) creating responder socket."
end

msg=''
while true do
  rc = responder_socket.recv_string(msg)
  if ZMQ::Util.resultcode_ok?(rc)
    ENV['DEBUG'] && puts("received message, rc: #{rc}, msg: #{msg}")

    msg = 'Roger'
    rc = responder_socket.send_string(msg)
    if ZMQ::Util.resultcode_ok?(rc)
      ENV['DEBUG'] && puts("sent reply, rc: #{rc}, msg: #{msg}")
    else
      ENV['DEBUG'] && puts("error sending reply (errno: #{ZMQ::Util.errno}")
    end
  end
end

responder_socket.close
ctx.terminate
