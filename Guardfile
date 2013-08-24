# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload', host: 'pg.dev' do
  watch(%r{app/views/.+\.(erb|haml|slim)})
  watch(%r{app/decorators/.+\.rb})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline for Javascripts
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(js|coffee))).*}) { |m| "/assets/#{m[3]}?body=1" }
  # Rails Assets Pipeline for Stylesheets
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|s[ac]ss|))).*}) { |m| "/assets/application.css?body=1" }
end
