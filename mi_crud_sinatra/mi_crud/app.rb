require 'sinatra/base'
require 'sinatra/activerecord'
require_relative 'models/item'
require_relative 'models/user'
require_relative 'helpers/auth_helpers'
require_relative 'controllers/auth_controller'
require_relative 'controllers/items_controller'

class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :database_file, File.join(__dir__, 'config', 'database.yml')

  enable :sessions
  set :session_secret, ENV.fetch('SESSION_SECRET') {
    'clave-solo-para-desarrollo-cambiala-en-produccion-' + 'x' * 40
  }

  use AuthController
  use ItemsController

  get('/') { redirect '/items' }

  run! if app_file == $0
end
