source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.0.6'

# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'

# Use Puma as the app server
gem 'puma', '~> 4.1'

# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  #marco de prueba RSpec a Ruby on Rails como una alternativa directa a su marco de prueba predeterminado
  # https://github.com/rspec/rspec-rails
  gem 'rspec-rails'
  gem 'rubocop'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Agregue un comentario que resuma el esquema actual en la parte superior o inferior
  # https://github.com/ctran/annotate_models
  gem 'annotate'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'

  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# https://guias.makeitreal.camp/ruby-on-rails-i/devise
# https://github.com/heartcombo/devise
# gem 'devise'

# Uso para manejo de fotografias,  Enlace:  https://github.com/carrierwaveuploader/carrierwave
gem 'carrierwave'

# gema para manejo de sessiones
# https://www.rubydoc.info/gems/activerecord-session_store/2.0.0
gem 'activerecord-session_store'

# Esta gema proporciona solo íconos gratuitos de Font-Awesome
# https://www.rubydoc.info/gems/font_awesome5_rails/1.5.0
gem 'font_awesome5_rails'

# Simple Form tiene como objetivo ser lo más flexible posible mientras lo ayuda con componentes poderosos para crear sus formularios.
# https://github.com/heartcombo/simple_form
gem 'simple_form'

# Le permite crear archivos de datos iniciales a partir de los datos existentes en su base de datos.
# https://www.rubydoc.info/gems/seed_dump/3.3.1
gem 'seed_dump'
gem "stimulus_reflex", "~> 3.4"
