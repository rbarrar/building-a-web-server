require "socket"

# Bind to port 9000
server = TCPServer.new 9000

# Start the main program loop, core of every server
loop do
  # Wait for a client to connect
  client = server.accept

  while line = client.gets
    puts line
    break if line == "\r\n"
  end
  
  # Write back through the socket to the client
  client.puts "Pong"
  # Close the socket so the client stops waiting
  client.close
end
