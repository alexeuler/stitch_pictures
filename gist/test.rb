require_relative "../lib/requests_queue"
require_relative "../lib/fetcher"

q = RequestsQueue.new
# item = q.pop
# item[:url].gsub!("png", "pgn")
threads = []
1.times do
  threads << Thread.new do
    fetcher = Fetcher.new(queue: q)
    fetcher.fetch_all
  end
end

threads.each {|t| t.join}