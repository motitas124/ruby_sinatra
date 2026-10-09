class ItemsController < Sinatra::Base
  set :views, File.expand_path('../views', __dir__)
  set :method_override, true   # permite usar PUT y DELETE desde formularios HTML

  helpers AuthHelpers

  # Protege todas las rutas del CRUD
  before '/items*' do
    require_login
  end

  error ActiveRecord::RecordNotFound do
    status 404
    'Item no encontrado'
  end

  # Leer (Read)
  get '/items' do
    @items = Item.order(id: :desc)
    @item  = Item.new
    erb :index
  end

  # Crear (Create)
  post '/items' do
    @item = Item.new(name: params[:name], description: params[:description])

    if @item.save
      redirect '/items'
    else
      @items = Item.order(id: :desc)
      erb :index
    end
  end

  # Mostrar formulario de edición
  get '/items/:id/edit' do
    @item = Item.find(params[:id])
    erb :edit
  end

  # Actualizar (Update)
  put '/items/:id' do
    @item = Item.find(params[:id])

    if @item.update(name: params[:name], description: params[:description])
      redirect '/items'
    else
      erb :edit
    end
  end

  # Eliminar (Delete)
  delete '/items/:id' do
    Item.find(params[:id]).destroy
    redirect '/items'
  end
end
