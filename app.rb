require 'sinatra'

BOUNDARY = "firstboundary123".freeze

get '/' do
  status 200
  response.headers["Content-Type"] =
    "multipart/mixed;boundary=#{BOUNDARY}"
  payload
end

private

def headers
  {"Content-Type" => "multipart/mixed;boundary=\"#{BOUNDARY}\""}
end

def payload
  body = []

  body << "--#{BOUNDARY}\r\n"
  body << "Content-type: application/json\r\n\r\n"
  body << "{\"1\": \"first\"}"

  body << "\r\n--#{BOUNDARY}\r\n"
  body << "Content-type: application/json\r\n\r\n"
  body << "{\"2\": \"second\"}"

  body << "\r\n--#{BOUNDARY}--\r\n"

  body.join
end
