# NOTE: only doing this in development as some production environments (Heroku)
# NOTE: are sensitive to local FS writes, and besides -- it's just not proper
# NOTE: to have a dev-mode tool do its thing in production.
if(Rails.env.development?)
  task :set_annotation_options do
    # You can override any of these by setting an environment variable of the
    # same name.
    Annotate.set_defaults({
      'position_in_routes'   => "before",
      'position_in_class'    => "before",
      'position_in_test'     => "before",
      'position_in_fixture'  => "before",
      'position_in_factory'  => "before",
      'show_indexes'         => "true",
      'simple_indexes'       => "false",
      'model_dir'            => "app/models",
      'include_version'      => "false",
      'require'              => "",
      'exclude_tests'        => "false",
      'exclude_fixtures'     => "false",
      'exclude_factories'    => "false",
      'ignore_model_sub_dir' => "false",
      'skip_on_db_migrate'   => "false",
      'format_bare'          => "true",
      'format_rdoc'          => "false",
      'format_markdown'      => "false",
      'sort'                 => "true",
      'force'                => "false",
      'trace'                => "false",
    })
  end

  # Comes with the current master when running `rails g annotate:install`
  # But somehow won't annotate my models correctly (only one)
  # Thus commented out
  # Annotate.load_tasks

  # Annotate models
  task :annotate do
    puts 'Annotating models...'
    system 'bundle exec annotate'
  end

  # Run annotate task after db:migrate
  #  and db:rollback tasks
  Rake::Task['db:migrate'].enhance do
    Rake::Task['annotate'].invoke
  end

  # Rake::Task['db:rollback'].enhance do
  #   Rake::Task['annotate'].invoke
  # end
end


