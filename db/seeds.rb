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
  {name: 'ActionMailer: Email Templating', lang: 'Ruby', repos: %w(plataformatec/markerb judofyr/temple), description: "Alternate Templating engines for your emails. Also have a look at the ActionView: Templating and Templating: HTML sections as you can use most of these gems as well. Also take a look at our Views: Templating Engines & Languages section. You can use almost all of the projects listed there for email views as well. Be sure to check out slim. You can also use plain text files with erb tags for text emails alongside slim templates for html emails."},
  {name: 'ActionMailer: Preview Emails', lang: 'Ruby', repos: %w(37signals/mail_view ryanb/letter_opener sj26/mailcatcher), description: 'Preview emails in the browser instead of sending them. Useful in development and for testing the design of emails and newsletters.'},
  # ActiveRecord
  {name: 'ActiveRecord: Soft Deleting / Paranoid Objects', lang: 'Ruby', repos: %w(radar/paranoia goncalossilva/rails3_acts_as_paranoid JackDanger/permanent_records teambox/immortal expectedbehavior/acts_as_archival nay/never_wastes socialcast/delete_paranoid), description: 'Instead of deleting objects from your database, keep them but mark them as deleted. Also take a look at the ActiveRecord: Versioning / History section.'},
  {name: 'ActiveRecord: Versioning, Auditing & History Tracking', lang: 'Ruby', repos: %w(collectiveidea/audited harleyttd/auditable airblade/paper_trail technoweenie/acts_as_versioned jmckible/version_fu bdurand/acts_as_revisionable Tapjoy/acts_as_approvable Sigiz/record_history seejohnrun/track_history nearinfinity/auditor), description: "Track changes to your model's data. Also take a look at ActiveRecord's built-in 'dirty object' functionality."},
  {name: 'ActiveRecord: Lists & Sortable Columns', lang: 'Ruby', repos: %w(swanandp/acts_as_list the-teacher/the_sortable_tree dadooda/handles_sortable_columns 12spokes/acts_as_restful_list codegram/resort mixonic/ranked-model shuber/sortable bogdan/datagrid thoughtbot/sortable_table), description: 'Also take a look at ActiveRecord: Nesting'},
  {name: 'ActiveRecord: Nesting', lang: 'Ruby', repos: %w(collectiveidea/awesome_nested_set mceachen/closure_tree amerine/acts_as_tree ryanb/nested_form stefankroes/ancestry elight/acts_as_commentable_with_threading the-teacher/the_sortable_tree clyfe/acts_as_nested_interval amatsuda/nested_scaffold thinkwell/mongoid_nested_set svenfuchs/simple_nested_set), description: ''},
  {name: 'ActiveRecord: Searching & Scoping', lang: 'Ruby', repos: %w(ernie/ransack ernie/squeel rails/arel ernie/meta_search binarylogic/searchlogic ernie/ransack wvanbergen/scoped_search novagile/scoped-search pioz/ximate sunspot/sunspot freelancing-god/thinking-sphinx karmi/tire mwmitchell/rsolr ryanb/xapit texticle/texticle jkraemer/acts_as_ferret  Casecommons/pg_search huacnlee/redis-search wvanbergen/scoped_search garaio/xapian_db dougal/acts_as_indexed grantr/rubberband), description: "There sure must be a good RailsCast on Searching. Seems as if there are at least two fundamentally different ways to search ActiveRecord objects and database tables: 1) external search server, 2) no external search server, but ActiveRecord Scopes. What is the best way?"},
  {name: 'ActiveRecord: Normalizing & Stripping Attributes', lang: 'Ruby', repos: %w(holli/auto_strip_attributes rmm5t/strip_attributes mdeering/attribute_normalizer), description: "Also take a look at Ruby's 'strip' method and Rails' built-in 'squish' method ('Returns the string, first removing all whitespace on both ends of the string, and then changing remaining consecutive whitespace groups into one space each.' - Rails API Docs. Also take a look at the Parsers: HTML Sanitization section."},
  {name: 'ActiveRecord: Enumartions & States', lang: 'Ruby', repos: %w(pluginaweek/state_machine twinslash/enumerize yonbergman/enumify beerlington/classy_enum electronick/enum_column cassiomarques/enumerate_it lwe/simple_enum novelys/static_list), description: ''},
  {name: 'ActiveRecord: Default Values for Attributes', lang: 'Ruby', repos: %w(), description: "There are various ways to set defaults for the objects created by a model. Next to the gems listed here they can be set in the database / database adapter using a Rails migration (as described here: [Rails Guides on Migrations](http://guides.rubyonrails.org/migrations.html). The community-driven [Rails Styleguide](https://github.com/bbatsov/rails-style-guide#migrations) recommends setting defaults in the model rather than a table."},

  # API
  {name: 'API: API Builders', lang: 'Ruby', repos: %w(fabrik42/acts_as_api), description: "Build an API for your application."},

  {name: 'Admin Interfaces', lang: 'Ruby', repos: %w(sferik/rails_admin gregbell/active_admin fesplugas/typus bigbinary/admin_data ianmurrays/active_invoices fhwang/admin_assistant elia/activeadmin-mongoid renderedtext/admin_view tomas/bowtie kryzhovnik/rails_admin_tag_list dce/rails_admin_interfaces activescaffold/active_scaffold puffer/puffer acesuares/inline_forms codez/dry_crud joost/admin_interface), description: "Add an admin interface to your Rails app."},
  # B

  # C
  # Coffeescript
  {name: 'Coffeescript: Guides / Styleguides', lang: 'JS', repos: %w(polarmobile/coffeescript-style-guide), description: ''},

  # D
  # Deployment
  {name: 'Deployment', lang: 'Ruby', repos: %w(opscode/rails-quick-start), description: ''},
  # Development
  {name: 'Development: Development Webserver', lang: 'Ruby', repos: %w(37signals/pow rodreegez/powder), description: 'Automatically run your apps on your local machine, and access them with special domains in your browser.'},

  # E
  # E-Commerce
  {name: 'E-Commerce: Online Shops', lang: 'Ruby', repos: %w(spree/spree drhenner/ror_ecommerce Shopify/shopify_app Shopify/shopify_api), description: "Online store related gems."},
  {name: 'E-Commerce: Fulfillment & Shipping', lang: 'Ruby', repos: %w(Shopify/active_shipping spree/spree_active_shipping Shopify/active_fulfillment), description: "Online store related gems."},
  {name: 'E-Commerce: Payments & API Clients for Payment Processing Services', lang: 'Ruby', repos: %w(Shopify/active_merchant chargify/chargify_api_ares tylerhunt/remit rlivsey/rspreedly spreedly/spreedly-gem expectedbehavior/cheddargetter_client_ruby recurly/recurly-client-ruby fnando/paypal-recurring pengwynn/chargify nov/paypal-express braintree/braintree_ruby tc/paypal_adaptive stripe/stripe-ruby), description: "Get paid for your work. Includes Services that offer recurring subscription billing as well as one-time payments. Can handle credit card payments as well as paypal and other forms."},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},

  # F
  # Forms
  {name: 'Forms: Form Builders', lang: 'Ruby', repos: %w(justinfrench/formtastic plataformatec/simple_form ryanb/nested_form nathanvda/cocoon stouset/twitter_bootstrap_form_for JangoSteve/remotipart plataformatec/mail_form mjbellantoni/formtastic-bootstrap rafaelfranca/simple_form-bootstrap sethvargo/bootstrap_forms tizoc/bureaucrat springbok/smerf joshsusser/informal potenza/bootstrap_form ksylvest/formula jeremyevans/forme), description: "Generate markup for your forms easily. Please get familiar with the form building tools shipped with Rails first before contemplating to use any of the listed gems."},
  {name: 'Forms: File Uploads & Processing', lang: 'Ruby', repos: %w(JangoSteve/remotipart markevans/dragonfly mwilliams/d2s3 apeacox/simple_form_fancy_uploads jnicklas/carrierwave thoughtbot/paperclip dwilkie/carrierwave_direct mischa78/boxroom newbamboo/rack-raw-upload websymphony/Rails3-Paperclip-Uploadify camelpunch/ungulate jstorimer/delayed_paperclip igor-alexandrov/paperclip-aws dripster82/paperclipdropbox nhocki/paperclip-s3 kellym/mongoid_paperclip_queue ksylvest/attached technoweenie/attachment_fu), description: "Upload files, process them, and/or store them directly on a cloud storage service such as Amazon's S3."},
  {name: 'Forms: Client-Side Validation', lang: 'Ruby', repos: %w(bcardarella/client_side_validations amatsuda/html5_validators dockyard/client_side_validations-simple_form), description: "Automatically validate forms on the client side using Javascript or the latest HTML5 Validation Standards. Rules can be automatically extracted from the validations set in your model."},
  {name: 'Forms: Multi-Step Forms / Wizard Forms', lang: 'Ruby', repos: %w(schneems/wicked intridea/rails_wizard antonversal/stepper jeffp/wizardly RailsApps/rails_apps_composer), description: "Also consider the corresponding JS Plugins."},
  {name: 'Forms: Datepickers', lang: 'Ruby', repos: %w(kristianmandrup/ui_datepicker-rails3 albertopq/jquery_datepicker trentrichardson/jQuery-Timepicker-Addon), description: ""},
  {name: 'Forms: Email & Contact Forms', lang: 'Ruby', repos: %w(plataformatec/mail_form jdutil/contact_us eric1234/rack_mailer), description: "Also consider the ActiveAttr gem and the matching Railscasts episode."},
  {name: 'Forms: Spam Minimization', lang: 'Ruby', repos: %w(curtis/honeypot-captcha moowahaha/despamilator sinisterchipmunk/bot-away joshfrench/rakismet dvyjones/defender matthutchinson/acts_as_textcaptcha gutomcosta/simple-spam-filter), description: "Act on this problem only when it is a problem. Premature optimization is your enemy. Spam protection is often done using a single form field hidden by CSS rules that has to remain blank. If a value has been filled in and is sent along you know only a spam bot could have filled that form. Also take a look at the Javascript: Captchas and Spam Minimization section."},
  # {name: 'Forms: Nested Forms', lang: 'Ruby', repos: %w(nathanvda/cocoon lailsonbm/awesome_nested_fields the-teacher/the_sortable_tree), description: ''},
  {name: 'Forms: Multi-Step Forms / Wizard Forms', lang: 'JS', repos: %w(wbotelhos/stepy kflorence/jquery-wizard thecodemine/formwizard dominicbarnes/jWizard mstratman/jQuery-Smart-Wizard), description: ""},

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
  {name: 'MongoID: Versioning, Auditing & History Tracking', lang: 'Ruby', repos: %w(aq1018/mongoid-history), description: ''},

  # N
  {name: 'Node: Guides / Styleguides', lang: 'JS', repos: %w(felixge/nodeguide.com), description: ''},

  # O
  {name: 'Office Radio', lang: 'Ruby', repos: %w(play/play), description: "Music makes the heart shine."},
  # Optimizing
  {name: 'Optimizing: Split Testing / A/B Testing', lang: 'Ruby', repos: %w(xing/absurdity andrew/split assaf/vanity jhubert/rails-split-tester hayesgm/mountain_goat), description: 'Optimizing your website conversion rates can include A/B-Testing, Split Testing, Multivariate Testing, and more. Test your assumptions to see what is not working and what is.'},
  {name: 'Optimizing: Split Testing / A/B Testing', lang: 'JS', repos: %w(jamesyu/cohorts grippy/node-multivariate thumbtack/abba jgallen23/dice-roll), description: 'Optimizing your website conversion rates can include A/B-Testing, Split Testing, Multivariate Testing, and more. Test your assumptions to see what is not working and what is.'},
  {name: 'Optimizing: Stylesheets', lang: 'Ruby', repos: %w(aanand/deadweight), description: ""},
  {name: 'Other Languages / Frameworks: Guides / Styleguides', lang: 'Ruby/JS', repos: %w(oreilly/couchdb-guide), description: ''},

  # P
  {name: 'Parsers: CSV', lang: 'Ruby', repos: %w(seamusabshere/data_miner), description: ''},
  {name: 'Parsers: HTML & Sanitizers', lang: 'Ruby', repos: %w(sparklemotion/nokogiri flavorjones/loofah), description: ''},
  {name: 'Parsers: JSON', lang: 'Ruby', repos: %w(ohler55/oj intridea/multi_json flori/json brianmario/yajl-ruby jnunemaker/crack kr/okjson), description: ''},
  {name: 'Parsers: Markdown', lang: 'Ruby', repos: %w(tanoku/redcarpet tanoku/sundown rtomayko/rdiscount github/github-flavored-markdown vigetlabs/acts_as_markup gettalong/kramdown postmodern/multi_markdown jgarber/redcloth), description: ""},
  {name: 'Parsers: XLS', lang: 'Ruby', repos: %w(seamusabshere/data_miner), description: ''},
  {name: 'Parsers: XML', lang: 'Ruby', repos: %w(jnunemaker/crack rubiii/nori sparklemotion/nokogiri flavorjones/loofah jnunemaker/happymapper seamusabshere/data_miner), description: ''},

  {name: 'Productivity: Project Management & Organization', lang: 'Ruby', repos: %w(redmine/redmine chiliproject/chiliproject gitlabhq/gitlabhq malclocke/fulcrum ari/jobsworth jamesu/railscollab Bettermeans/bettermeans camelpunch/simply_agile), description: ""},
  {name: 'Productivity: Password Management', lang: 'Ruby', repos: %w(janlelis/pws), description: ""},

  # Q

  # R
  {name: 'Routing: Subdomains', lang: 'Ruby', repos: %w(RailsApps/rails3-subdomains), description: "Working with Subdomains got much easier in Rails 3.1+. Take a look at the Rails Guide [Rails Routing from the Outside in](http://guides.rubyonrails.org/routing.html)."},
  {name: 'Ruby: Development Machine Setup', lang: 'Ruby', repos: %w(atmos/smeagol thoughtbot/laptop oscardelben/RailsOneClick tokaido/tokaidoapp), description: 'Set up your laptop for Ruby or Rails development.'},
  {name: 'Ruby: Manage Ruby Versions', lang: 'Ruby', repos: %w(wayneeseguin/rvm sstephenson/rbenv), description: 'Install the latest ruby builds on your laptop. You can also use different ruby versions on different projects.'},

  # S
  {name: 'Statistics', lang: 'Ruby', repos: %w(thirtysixthspan/descriptive_statistics), description: ''},
  # Styling
  {name: 'Styling: CSS Preprocessors', lang: 'Ruby/Design', repos: %w(nex3/sass chriseppstein/compass cowboyd/less.rb cloudhead/less.js), description: "Still writing plain CSS? Consider using SASS, Less, Stylus or any other preprocessor. They generally give you advanced features like variables, mixins, color functions and more. For some of them there are great mixin libraries available."},
  {name: 'Styling: Design Frameworks', lang: 'Design/Ruby', repos: %w(twitter/bootstrap zurb/foundation h5bp/html5-boilerplate necolas/normalize.css joshuaclayton/blueprint-css seyhunak/twitter-bootstrap-rails thomas-mcdonald/bootstrap-sass), description: "Build great looking websites with ease."},
  {name: 'Styling: Sass: Mixin Libraries', lang: 'Ruby', repos: %w(thoughtbot/bourbon), description: ""},

  # T
  {name: 'Templating: PDF Generators', lang: 'Ruby', repos: %w(mbleigh/princely fnando/kitabu), description: ''},
  {name: 'Templating: JSON', lang: 'Ruby', repos: %w(nesquena/rabl fabrik42/acts_as_api), description: ''},
  {name: 'Templating: XML', lang: 'Ruby', repos: %w(nesquena/rabl fabrik42/acts_as_api), description: ''},

  # U
  {name: 'User Management: Authentication', lang: 'Ruby', repos: %w(plataformatec/devise NoamB/sorcery thoughtbot/clearance intridea/omniauth), description: 'Authenticate your users.'},
  {name: 'User Management: Authorization', lang: 'Ruby', repos: %w(ryanb/cancan stffn/declarative_authorization kristianmandrup/cantango EppO/rolify platform45/easy_roles nathanl/authority james2m/canard mcrowe/roleable the-teacher/the_role), description: 'Manage user roles and abilities. There are various concepts when it come to Authorization.'},

  # V
  {name: 'Views: Table Builders', lang: 'Ruby', repos: %w(provideal/tabulatr watu/table_builder jgdavey/tabletastic tokumine/fusion_tables pluginaweek/table_helper lunich/table_for), description: "Render table with searching and sorting helpers."},
  {name: 'Views: Templating Engines & Languages', lang: 'Ruby', repos: %w(haml/haml stonean/slim Shopify/liquid rtomayko/tilt defunkt/mustache markaby/markaby blambeau/wlang), description: "Tired of <html>? Try slim and companions."},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},

  # W

  # X

  # Y

  # Z

  # 123


  # JS
  {name: 'Context Menus', lang: 'JS', repos: %w(medialize/jQuery-contextMenu), description: ""},


  {name: 'Web Application Frameworks', lang: 'Ruby', repos: %w(rails/rails sinatra/sinatra), description: 'Build web applications easily with style.'},
  {name: 'Object Tagging / Marking / Liking', lang: 'Ruby', repos: %w(mbleigh/acts-as-taggable-on bradphelan/rocket_tag schneems/Likeable chrome/markable), description: 'Tagging and marking for your ActiveRecord models.'},
  {name: 'Background Jobs', lang: 'Ruby', repos: %w(mperham/sidekiq mperham/girl_friday defunkt/resque collectiveidea/delayed_job ryandotsmith/queue_classic bkeepers/qu ruby-amqp/amqp), description: 'Process worker tasks in the background.'},
  {name: 'Project Generators / Templates', lang: 'Ruby', repos: %w(jeriko/app_drone RailsApps/rails_apps_composer RailsApps/rails3-application-templates), description: 'Get your project off the ground with ease.'},
  {name: 'Icon Fonts', lang: 'Design', repos: %w(FortAwesome/Font-Awesome pfefferle/openwebicons zurb/foundation-icons), description: 'Icon fonts are the new way to get icons on a website. Advantages over image files: Scalable to every size because they are vectorised; Most CSS3 Properties are available: Shadows, Borders etc. Color can be changed freely.'},
  {name: 'Ruby: Guides / Styleguides', lang: 'Ruby', repos: %w(bbatsov/rails-style-guide bbatsov/ruby-style-guide copycopter/style-guide davetron5000/ruby-style), description: 'Write maintainable ruby code.'},
  {name: 'Guides / Styleguides', lang: 'Design', repos: %w(necolas/idiomatic-css), description: 'Write consistent and maintainable view files. Book recommendation: The Rails View, Pragmatic Programmers.'},
  {name: 'Twitter API Clients', lang: 'Ruby', repos: %w(intridea/tweetstream jnunemaker/twitter sferik/t jugyo/earthquake marcel/twurl twitter/twitter-text-rb voloko/twitter-stream seejohnrun/console_tweet), description: 'API Wrappers for Twitter.'},
  {name: 'Rubies', lang: 'Ruby', repos: %w(ruby/ruby mruby/mruby jruby/jruby rubinius/rubinius), description: 'Ruby Implementations.'},
  {name: 'Collaboration: Source Code Management', lang: 'Ruby/JS', repos: %w(gitlabhq/gitlabhq), description: 'Version Control for your code.'},
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