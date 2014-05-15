require_relative "../lib/requests_queue"
require_relative "../lib/fetcher"

class Application

  THREADS_COUNT = 5

  def initialize(args={})
    @threads_count = args[:threads_count] || THREADS_COUNT
  end

  def run
    job_queue = RequestsQueue.new
    threads = []
    @threads_count.times do
      threads << Thread.new do
        fetcher = Fetcher.new(queue: job_queue)
        fetcher.fetch_all
      end
    end

    threads.each {|t| t.join}
  end

end