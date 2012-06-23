# ruby encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# Empty Items List:    {name: '', lang: 'Ruby', repos: %w(), description: ""},
#
# Be sure to respect mass assignment protection!

# Build seeds
seeds = [
  # A
  # ActionMailer
  {name: 'ActionMailer: Email Templating', lang: 'Ruby', repos: %w(plataformatec/markerb), description: 'Alternate Templating engines for your emails. Also have a look at the ActionView: Templating and Templating: HTML sections as you can use most of these gems as well.'},
  {name: 'ActionMailer: Preview Emails', lang: 'Ruby', repos: %w(37signals/mail_view ryanb/letter_opener sj26/mailcatcher), description: 'Preview emails in the browser instead of sending them. Useful in development and for testing the design of emails and newsletters.'},
  # ActiveRecord
  {name: 'ActiveRecord: Soft Deleting / Paranoid Objects', lang: 'Ruby', repos: %w(radar/paranoia goncalossilva/rails3_acts_as_paranoid JackDanger/permanent_records teambox/immortal expectedbehavior/acts_as_archival nay/never_wastes socialcast/delete_paranoid), description: 'Instead of deleting objects from your database, keep them but mark them as deleted. Also take a look at the ActiveRecord: Versioning / History section.'},
  {name: 'ActiveRecord: Versioning, Auditing & History Tracking', lang: 'Ruby', repos: %w(collectiveidea/audited harleyttd/auditable airblade/paper_trail technoweenie/acts_as_versioned jmckible/version_fu bdurand/acts_as_revisionable Tapjoy/acts_as_approvable Sigiz/record_history seejohnrun/track_history nearinfinity/auditor), description: "Track changes to your model's data. Also take a look at ActiveRecord's built-in 'dirty object' functionality."},
  {name: 'ActiveRecord: Lists & Sortable Columns', lang: 'Ruby', repos: %w(swanandp/acts_as_list the-teacher/the_sortable_tree dadooda/handles_sortable_columns 12spokes/acts_as_restful_list codegram/resort mixonic/ranked-model shuber/sortable bogdan/datagrid thoughtbot/sortable_table), description: 'Also take a look at ActiveRecord: Nesting'},
  {name: 'ActiveRecord: Nesting', lang: 'Ruby', repos: %w(collectiveidea/awesome_nested_set mceachen/closure_tree amerine/acts_as_tree ryanb/nested_form stefankroes/ancestry elight/acts_as_commentable_with_threading the-teacher/the_sortable_tree clyfe/acts_as_nested_interval amatsuda/nested_scaffold thinkwell/mongoid_nested_set svenfuchs/simple_nested_set), description: ''},
  {name: 'ActiveRecord: Searching & Scoping', lang: 'Ruby', repos: %w(ernie/ransack ernie/squeel rails/arel ernie/meta_search), description: 'What is the best way to search for data?'},
  {name: 'ActiveRecord: Normalizing & Stripping Attributes', lang: 'Ruby', repos: %w(holli/auto_strip_attributes rmm5t/strip_attributes mdeering/attribute_normalizer), description: "Also take a look at Ruby's 'strip' method and Rails' built-in 'squish' method ('Returns the string, first removing all whitespace on both ends of the string, and then changing remaining consecutive whitespace groups into one space each.' - Rails API Docs. Also take a look at the Parsers: HTML Sanitization section."},
  {name: 'ActiveRecord: Enumartions & States', lang: 'Ruby', repos: %w(pluginaweek/state_machine twinslash/enumerize yonbergman/enumify beerlington/classy_enum electronick/enum_column cassiomarques/enumerate_it lwe/simple_enum novelys/static_list), description: ''},
  {name: 'ActiveRecord: Default Values for Attributes', lang: 'Ruby', repos: %w(), description: "There are various ways to set defaults for the objects created by a model. Next to the gems listed here they can be set in the database / database adapter using a Rails migration (as described here: [Rails Guides on Migrations](http://guides.rubyonrails.org/migrations.html). The community-driven [Rails Styleguide](https://github.com/bbatsov/rails-style-guide#migrations) recommends setting defaults in the model rather than a table."},
  {name: 'API Builders', lang: 'Ruby', repos: %w(fabrik42/acts_as_api), description: ''},

  # B

  # C
  {name: 'Coffeescript: Guides / Styleguides', lang: 'JS', repos: %w(polarmobile/coffeescript-style-guide), description: ''},

  # D
  {name: 'Deployment', lang: 'Ruby', repos: %w(opscode/rails-quick-start), description: ''},

  # E

  # F
  {name: 'Forms: Nesting', lang: 'Ruby', repos: %w(nathanvda/cocoon lailsonbm/awesome_nested_fields the-teacher/the_sortable_tree), description: ''},

  # G
  {name: 'Git: Guides / Styleguides', lang: 'Ruby', repos: %w(rogerdudler/git-guide blynn/gitmagic), description: ''},

  # H

  # I

  # J

  # K

  # L
  {name: 'Learning Rails', lang: 'Ruby', repos: %w(devalot/ror-example), description: 'Getting better in Rails development every day is considered a noble cause.'},
  {name: 'Learning Ruby', lang: 'Ruby', repos: %w(JoshCheek/ruby-kickstart the-teacher/Ruby-Lessons), description: 'Get better in Ruby development every day is something to live by.'},

  # M
  {name: 'Marketing Testing / Optimization', lang: 'Ruby', repos: %w(xing/absurdity andrew/split assaf/vanity jhubert/rails-split-tester hayesgm/mountain_goat), description: 'Optimizing your website conversion rates can include A/B-Testing, Split Testing, Multivariate Testing, and more. Test your assumptions to see what is not working and what is.'},
  {name: 'Marketing Testing / Optimization', lang: 'JS', repos: %w(jamesyu/cohorts grippy/node-multivariate thumbtack/abba jgallen23/dice-roll), description: 'Optimizing your website conversion rates can include A/B-Testing, Split Testing, Multivariate Testing, and more. Test your assumptions to see what is not working and what is.'},
  {name: 'MongoORM: Versioning, Auditing & History Tracking', lang: 'Ruby', repos: %w(aq1018/mongoid-history), description: ''},

  # N
  {name: 'Node: Guides / Styleguides', lang: 'JS', repos: %w(felixge/nodeguide.com), description: ''},

  # O
  {name: 'Other Languages / Frameworks: Guides / Styleguides', lang: 'Ruby/JS', repos: %w(oreilly/couchdb-guide), description: ''},

  # P
  {name: 'Parsers: CSV', lang: 'Ruby', repos: %w(seamusabshere/data_miner), description: ''},
  {name: 'Parsers: HTML & Sanitizers', lang: 'Ruby', repos: %w(sparklemotion/nokogiri flavorjones/loofah), description: ''},
  {name: 'Parsers: JSON', lang: 'Ruby', repos: %w(ohler55/oj intridea/multi_json flori/json brianmario/yajl-ruby jnunemaker/crack kr/okjson), description: ''},
  {name: 'Parsers: Markdown', lang: 'Ruby', repos: %w(tanoku/redcarpet tanoku/sundown rtomayko/rdiscount github/github-flavored-markdown vigetlabs/acts_as_markup gettalong/kramdown postmodern/multi_markdown jgarber/redcloth), description: ""},
  {name: 'Parsers: XLS', lang: 'Ruby', repos: %w(seamusabshere/data_miner), description: ''},
  {name: 'Parsers: XML', lang: 'Ruby', repos: %w(jnunemaker/crack rubiii/nori sparklemotion/nokogiri flavorjones/loofah jnunemaker/happymapper seamusabshere/data_miner), description: ''},

  # Q

  # R
  {name: 'Routing: Subdomains', lang: 'Ruby', repos: %w(RailsApps/rails3-subdomains), description: "Working with Subdomains got much easier in Rails 3.1+. Take a look at the Rails Guide [Rails Routing from the Outside in](http://guides.rubyonrails.org/routing.html)."},
  {name: 'Ruby: Development Machine Setup', lang: 'Ruby', repos: %w(atmos/smeagol thoughtbot/laptop oscardelben/RailsOneClick tokaido/tokaidoapp), description: 'Set up your laptop for Ruby or Rails development.'},
  {name: 'Ruby: Manage Ruby Versions', lang: 'Ruby', repos: %w(wayneeseguin/rvm sstephenson/rbenv), description: 'Install the latest ruby builds on your laptop. You can also use different ruby versions on different projects.'},

  # S
  {name: 'Statistics', lang: 'Ruby', repos: %w(thirtysixthspan/descriptive_statistics), description: ''},

  # T
  {name: 'Templating: PDF Generators', lang: 'Ruby', repos: %w(mbleigh/princely fnando/kitabu), description: ''},
  {name: 'Templating: JSON', lang: 'Ruby', repos: %w(nesquena/rabl fabrik42/acts_as_api), description: ''},
  {name: 'Templating: XML', lang: 'Ruby', repos: %w(nesquena/rabl fabrik42/acts_as_api), description: ''},

  # U
  {name: 'User Management: Authentication', lang: 'Ruby', repos: %w(plataformatec/devise NoamB/sorcery thoughtbot/clearance intridea/omniauth), description: 'Authenticate your users.'},
  {name: 'User Management: Authorization', lang: 'Ruby', repos: %w(ryanb/cancan stffn/declarative_authorization kristianmandrup/cantango nathanl/authority james2m/canard mcrowe/roleable the-teacher/the_role), description: 'Manage user roles and abilities. There are various concepts when it come to Authorization.'},

  # V

  # W

  # X

  # Y

  # Z

  # 123
  {name: 'Web Application Framework', lang: 'Ruby', repos: %w(rails/rails sinatra/sinatra), description: 'Build web applications easily with style.'},
  {name: 'Design Framework', lang: 'Design', repos: %w(twitter/bootstrap zurb/foundation h5bp/html5-boilerplate necolas/normalize.css), description: 'Build well designed websites with ease. Design Frameworks like Twitter Bootstrap and Zurb Foundation include a grid system, pre-styled buttons and form, and many design elements that you can use out of the box to quickly get a great looking website up and running. Of course you can always customize them to the fullest extent.'},
  {name: 'Development Server', lang: 'Ruby', repos: %w(37signals/pow rodreegez/powder), description: 'Automatically run your apps on your local machine, and access them with special domains in your browser.'},
  {name: 'Object Tagging / Marking / Liking', lang: 'Ruby', repos: %w(mbleigh/acts-as-taggable-on bradphelan/rocket_tag schneems/Likeable chrome/markable), description: 'Tagging and marking for your ActiveRecord models.'},
  {name: 'Background Jobs', lang: 'Ruby', repos: %w(mperham/sidekiq mperham/girl_friday defunkt/resque collectiveidea/delayed_job ryandotsmith/queue_classic bkeepers/qu ruby-amqp/amqp), description: 'Process worker tasks in the background.'},
  {name: 'Project Generators / Templates', lang: 'Ruby', repos: %w(jeriko/app_drone RailsApps/rails_apps_composer RailsApps/rails3-application-templates), description: 'Get your project off the ground with ease.'},
  {name: 'Icon Fonts', lang: 'Design', repos: %w(FortAwesome/Font-Awesome pfefferle/openwebicons zurb/foundation-icons), description: 'Icon fonts are the new way to get icons on a website. Advantages over image files: Scalable to every size because they are vectorised; Most CSS3 Properties are available: Shadows, Borders etc. Color can be changed freely.'},
  {name: 'Ruby: Guides / Styleguides', lang: 'Ruby', repos: %w(bbatsov/rails-style-guide bbatsov/ruby-style-guide copycopter/style-guide davetron5000/ruby-style), description: 'Write maintainable ruby code.'},
  {name: 'Guides / Styleguides', lang: 'Design', repos: %w(necolas/idiomatic-css), description: 'Write consistent and maintainable view files. Book recommendation: The Rails View, Pragmatic Programmers.'},
  {name: 'Twitter API Clients', lang: 'Ruby', repos: %w(intridea/tweetstream jnunemaker/twitter sferik/t jugyo/earthquake marcel/twurl twitter/twitter-text-rb voloko/twitter-stream seejohnrun/console_tweet), description: 'API Wrappers for Twitter.'},
  {name: 'Rubies', lang: 'Ruby', repos: %w(ruby/ruby mruby/mruby jruby/jruby rubinius/rubinius), description: 'Ruby Implementations.'},
  {name: 'Source Code Management', lang: 'Ruby/JS', repos: %w(gitlabhq/gitlabhq), description: 'Version Control for your code.'},
  {name: 'Collaboration / Project Management',lang: 'Ruby/JS', repos: %w(teambox/teambox), description: 'Team collaboration.'},
  {name: 'Rails App Tutorials', lang: 'Ruby', repos: %w(RailsApps/rails3-bootstrap-devise-cancan sferik/sign-in-with-twitter RailsApps/rails-prelaunch-signup RailsApps/rails3-mongoid-omniauth RailsApps/rails3-mongoid-devise RailsApps/rails3-bootstrap-devise-cancan RailsApps/rails3-devise-rspec-cucumber RailsApps/rails3-subdomains), description: 'Example apps and tutorials.'},
  {name: 'Textmate and Sublime Text Snippets', lang: 'Ruby/JS/Design', repos: %w(devtellect/sublime-twitter-bootstrap-snippets), description: 'Code Editor snippets. Mostly Textmate and Sublime Text. You can generally use Textmate Plugins in Sublime Text 2.'},
  {name: 'Twitter Bootstrap for Rails', lang: 'Ruby/Design', repos: %w(mjbellantoni/formtastic-bootstrap rafaelfranca/simple_form-bootstrap sethvargo/bootstrap_forms seyhunak/twitter-bootstrap-rails metaskills/less-rails-bootstrap anjlab/bootstrap-rails yabawock/bootstrap-sass-rails xdite/bootstrap-helper yrgoldteeth/bootstrap-will_paginate decioferreira/bootstrap-generators pusewicz/twitter-bootstrap-markup-rails thomaspark/bootswatch anjlab/bootstrap-rails markdotto/bootstrap-university), description: 'Helpers for using Twitter Bootstrap with Rails.'},
  {name: 'Web Design Elements', lang: 'Design', repos: %w(todc/css3-google-buttons necolas/normalize.css necolas/css3-github-buttons michenriksen/css3buttons), description: 'Buttons, Form Styles, Cross-Browser Styles etc.'},
]

puts "Writing Seeds..."

# Enter or update seeds
seeds.each do |seed|

  # Create or update repos
  seed[:repos].each do |full_name|
    repo = Repo.find_or_initialize_by_full_name(full_name)

    # Assign multiple categories to a repo while seeding
    categories = []
    categories << repo.category_list
    categories << "#{ seed[:name] } (#{ seed[:lang] })"
    repo.category_list = categories.join(', ')

    repo.save
  end

  # Create or update categories
  category = Category.find_or_initialize_by_name("#{ seed[:name] } (#{ seed[:lang] })")
  category.description ||= seed[:description]
  category.language_list = seed[:lang].split('/').join(', ')
  category.save
end

puts "Running 'Updater.update_repos_from_github'."
Updater.update_repos_from_github

puts "Running 'Updater.update_categories_from_repos'."
Updater.update_categories_from_repos

puts 'Finished writing seeds successfully.'