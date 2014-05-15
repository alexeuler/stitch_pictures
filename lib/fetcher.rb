require 'net/http'

class Fetcher

  def self.fetch(args = {})
    url = args[:url]
    filename = args[:filename]
    uri = URI.parse(url)
    Net::HTTP.start(uri.host, uri.port) do |http|
      resp = http.get(uri.path)
      file = Tempfile.new('foo', Dir.tmpdir, 'wb+')
      file.write(resp.body)
      file.flush
      file
    end
  end

end