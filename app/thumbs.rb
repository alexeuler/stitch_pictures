require_relative "../lib/fetcher"
require_relative "../lib/enums"

job_queue = Queue.new

prefix = "http://originalstitch.com/"

Enums::FABRICS.each do |fabric|
  url = prefix+"_media/fabrics/full/#{fabric}.jpg"
  filename = "item_full_fabric_#{fabric}.jpg"
  job_queue.push url:url, filename: filename
end

Enums::ITEMS[:collar][:type].each do |collar|
  url = prefix+"_media/collars/small/#{collar}.jpg?v=2"
  filename = "item_collar_#{collar}.jpg"
  job_queue.push url:url, filename: filename
end

Enums::ITEMS[:cuffs][:type].each do |cuff|
  url = prefix+"_media/cuffs/small/#{cuff}.jpg?v=2"
  filename = "item_cuff_#{cuff}.jpg"
  job_queue.push url:url, filename: filename
end

Enums::BUTTONS[:color].each do |color|
  url = prefix+"_media/buttons/small/#{color}.jpg?v=3"
  filename = "item_button_#{color}.jpg"
  job_queue.push url:url, filename: filename
end

threads = []
5.times do
  threads << Thread.new do
    fetcher = Fetcher.new(queue: job_queue)
    fetcher.fetch_all
  end
end

threads.each {|t| t.join}

