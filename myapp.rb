
require 'net/http'
require 'uri'

url = ARGV[0]
uri = URI.parse(url)
http_method = ARGV[1].upcase

if http_method == "GET"

  response = Net::HTTP.get_response(uri)
  puts response.body 

elsif http_method == "POST"

  title = ARGV[2]
  description = ARGV[3]

  require 'json'
  request = Net::HTTP::Post.new(uri)
  request.content_type = "application/json"
  request.body = JSON.dump({
    "book" => {
      "title" => title ,
      "description" => description
    }
  })
  req_options = {
    use_ssl: uri.scheme == "https",
  }
  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end
  puts response.body

elsif http_method == "DELETE"

  request = Net::HTTP::Delete.new(uri)
  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end
  puts response.body

else
  puts "please input GET or PUT or DELETE"
end
