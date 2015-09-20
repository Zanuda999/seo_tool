require 'rubygems'
require 'bundler'

# pull in the helpers and controllers
Dir.glob('./app/{helpers,controllers}/*.rb').each { |file| require file }

map('/') { run SeoToolController }
map('/pages/') { run PageController }