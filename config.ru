require 'sinatra/base'

use Rack::Static, :urls => ['/index.html', '/index_ES.html', '/assets', '/style.css', '/privacidad.pdf'], :root => 'public'

Dir.glob('./app/*.rb').each { |file| require file }
Dir.glob('./app/parser/*.rb').each { |file| require file }

map('/api/v1') { run RouterV1 }
map('/') { run PublicRouter }

