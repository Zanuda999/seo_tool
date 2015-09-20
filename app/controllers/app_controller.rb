require 'sinatra'
require 'slim'

class AppController < Sinatra::Base

  set :views, File.expand_path('../../views', __FILE__)

  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    username == 'admin' and password == 'admin'
  end

end