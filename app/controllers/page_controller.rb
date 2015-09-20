require 'sinatra'
require 'slim'
require 'json'

class PageController < AppController

  get '/:page_name' do
    @page_name = params[:page_name]
    _file = File.read("public/reports/#{@page_name}")
    @page_data = JSON.parse(_file)

    slim :page
  end

end