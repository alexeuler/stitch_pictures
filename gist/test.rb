require_relative "../lib/requests_queue"
require_relative "../lib/fetcher"

q = RequestsQueue.new
item = q.pop
# item[:url].gsub!("png", "pgn")
Fetcher.fetch(item)