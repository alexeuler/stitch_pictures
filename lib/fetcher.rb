require 'net/http'

class Fetcher

  PATH = File.expand_path("../../images",__FILE__)

  def self.fetch(args = {})
    url = args[:url]
    filename = PATH + "/" + args[:filename]
    return if File.exists?(filename)
    uri = URI.parse(url)
    Net::HTTP.start(uri.host, uri.port) do |http|
      resp = http.get(uri.path)
      unless resp.code == 200
        puts "Error: #{resp.body}"
        return
      end
      file = File.new(filename, 'wb')
      file.write(resp.body)
      file.flush
      file
    end
  end

end