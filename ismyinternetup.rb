require 'socket'

def ping_loop
  loop do
    begin
      s = TCPSocket.new('8.8.8.8', 53)
      puts "~~~< CONNECTION ESTABLISHED >~~~"
      s.close
      break
    rescue Exception => e
      puts e.message
      #puts e.backtrace.inspect
    end
    sleep 0.1
  end
  end

t = Thread.new{ping_loop}
t.join
