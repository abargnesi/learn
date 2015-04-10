require 'ffi-rzmq'

# Does not address:
# - message send and receive timeouts
# - signal handling

ctx = ZMQ::Context.create
requester_socket = ctx.socket(ZMQ::REQ)
rc = requester_socket.connect('tcp://127.0.0.1:9090')

# check result code of creating socket; fail if zero
if rc == -1
  raise "Error (#{ZMQ::Util.errno}) creating requester socket."
end

message_count         = 0
conversation_time_sum = 0
msg=''
(ENV['MSG_COUNT'].to_i || 1000).times do
  start_time = (Time.new.to_f * 1000).to_i
  msg = 'Halo? Are you there?'
  rc = requester_socket.send_string(msg)
  if ZMQ::Util.resultcode_ok?(rc)
    ENV['DEBUG'] && puts("sent message, rc: #{rc}, msg: #{msg}")

    rc = requester_socket.recv_string(msg)
    if ZMQ::Util.resultcode_ok?(rc)
      ENV['DEBUG'] && puts("received reply, rc: #{rc}, msg: #{msg}")
    else
      ENV['DEBUG'] && puts("error receiving reply (errno: #{ZMQ::Util.errno}")
    end
  end
  end_time = (Time.new.to_f * 1000).to_i
  message_count += 1
  conversation_time_sum += (end_time - start_time)
end

puts "Average conversation time (in milliseconds): #{conversation_time_sum.to_f / message_count.to_f}"

requester_socket.close
ctx.terminate
