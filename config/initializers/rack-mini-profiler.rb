Rack::MiniProfiler.config.skip_paths << '/__rack/' # skip rack livereload assets
Rack::MiniProfiler.config.skip_paths << '/__better_erros/' # skip better errors page

Rack::MiniProfiler.config.position = 'right'
