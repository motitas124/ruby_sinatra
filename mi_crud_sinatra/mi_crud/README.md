# Mi CRUD con Sinatra + ActiveRecord (MVC) con Login

Requisitos: Ruby 3.1 o superior.

## Ejecutar (en la terminal de VS Code)

    bundle install
    bundle exec rake db:migrate
    bundle exec ruby app.rb

Abrir http://localhost:4567

## Estructura MVC

- Modelo:      models/ y db/migrate/
- Vista:       views/ (archivos .erb)
- Controlador: controllers/ (auth_controller.rb e items_controller.rb)
- Helpers:     helpers/auth_helpers.rb
