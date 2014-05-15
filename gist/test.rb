require_relative "../lib/requests_queue"

q = RequestsQueue.new
while not q.empty?
  p q.pop[:url]
end