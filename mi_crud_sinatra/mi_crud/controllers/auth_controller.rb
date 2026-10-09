class AuthController < Sinatra::Base
  set :views, File.expand_path('../views', __dir__)
  helpers AuthHelpers

  # Registro
  get '/register' do
    redirect '/items' if logged_in?
    @user = User.new
    erb :register
  end

  post '/register' do
    @user = User.new(email: params[:email], password: params[:password],
                     password_confirmation: params[:password_confirmation])

    if @user.save
      session.clear
      session[:user_id] = @user.id
      redirect '/items'
    else
      erb :register
    end
  end

  # Inicio de sesión
  get '/login' do
    redirect '/items' if logged_in?
    erb :login
  end

  post '/login' do
    user = User.find_by(email: params[:email].to_s.strip.downcase)

    if user && user.authenticate(params[:password])
      session.clear
      session[:user_id] = user.id
      redirect '/items'
    else
      @error = 'Correo o contraseña incorrectos'
      erb :login
    end
  end

  # Cierre de sesión
  post '/logout' do
    session.clear
    redirect '/login'
  end
end
