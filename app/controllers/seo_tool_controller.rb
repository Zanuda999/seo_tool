require 'sinatra'
require 'slim'
require 'open-uri'
require 'nokogiri'
require 'byebug'
require 'json'
require 'net/http'

class SeoToolController < AppController

  get '/' do
    @file_names = Dir.entries('public/reports').select{|f| !File.directory? f}
    slim :index
  end

  post '/' do
    if params[:url][0..6] == 'http://'
      _page_url =  params[:url]
    else
      _page_url =  "http://#{params[:url]}"
    end
    begin
      _response_header = open(_page_url){|f| f.meta  }
    rescue SocketError, URI::InvalidURIError
      redirect '/'
    end
    _body = Nokogiri::HTML(open(_page_url))
    _anchors = _body.css('a')
    _links = []
    _anchors.each do |a|
      _links << {href: a['href'], name: a.text, rel: a['rel'], target: a['target']}
    end
    _page_data = {
        header: _response_header,
        links: _links,
        location: {
            ip: request.ip,
            port: request.port
          }
      }
    _file_name = "public/reports/#{_page_url[7..-1]}_#{DateTime.now.strftime("%F %T")}"
    File.open(_file_name, 'w') {|f| f.write(_page_data.to_json) }
    redirect '/'
  end

end