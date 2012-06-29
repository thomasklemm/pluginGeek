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
  {name: 'ActiveRecord: Versioning, Auditing & History Tracking', lang: 'Ruby', repos: %w(collectiveidea/audited harleyttd/auditable airblade/paper_trail technoweenie/acts_as_versioned jmckible/version_fu bdurand/acts_as_revisionable Tapjoy/acts_as_approvable Sigiz/record_history seejohnrun/track_history nearinfinity/auditor laserlemon/vestal_versions), description: "Track changes to your model's data. Also take a look at ActiveRecord's built-in 'dirty object' functionality."},
  {name: 'ActiveRecord: Lists & Sortable Columns', lang: 'Ruby', repos: %w(swanandp/acts_as_list the-teacher/the_sortable_tree dadooda/handles_sortable_columns 12spokes/acts_as_restful_list codegram/resort mixonic/ranked-model shuber/sortable bogdan/datagrid thoughtbot/sortable_table), description: 'Also take a look at ActiveRecord: Nesting'},
  {name: 'ActiveRecord: Nesting', lang: 'Ruby', repos: %w(collectiveidea/awesome_nested_set mceachen/closure_tree amerine/acts_as_tree ryanb/nested_form stefankroes/ancestry elight/acts_as_commentable_with_threading the-teacher/the_sortable_tree clyfe/acts_as_nested_interval amatsuda/nested_scaffold thinkwell/mongoid_nested_set svenfuchs/simple_nested_set), description: ''},
  {name: 'ActiveRecord: Searching & Scoping', lang: 'Ruby', repos: %w(ernie/ransack ernie/squeel rails/arel ernie/meta_search binarylogic/searchlogic ernie/ransack wvanbergen/scoped_search novagile/scoped-search pioz/ximate sunspot/sunspot freelancing-god/thinking-sphinx karmi/tire mwmitchell/rsolr ryanb/xapit texticle/texticle jkraemer/acts_as_ferret  Casecommons/pg_search huacnlee/redis-search wvanbergen/scoped_search garaio/xapian_db dougal/acts_as_indexed grantr/rubberband ernie/meta_where), description: "There sure must be a good RailsCast on Searching. Seems as if there are at least two fundamentally different ways to search ActiveRecord objects and database tables: 1) external search server, 2) no external search server, but ActiveRecord Scopes. What is the best way?"},
  {name: 'ActiveRecord: Normalizing & Stripping Attributes', lang: 'Ruby', repos: %w(holli/auto_strip_attributes rmm5t/strip_attributes mdeering/attribute_normalizer), description: "Also take a look at Ruby's 'strip' method and Rails' built-in 'squish' method ('Returns the string, first removing all whitespace on both ends of the string, and then changing remaining consecutive whitespace groups into one space each.' - Rails API Docs. Also take a look at the Parsers: HTML Sanitization section."},
  {name: 'ActiveRecord: Enumerations & State-Machines', lang: 'Ruby', repos: %w(svenfuchs/simple_states pluginaweek/state_machine twinslash/enumerize yonbergman/enumify beerlington/classy_enum electronick/enum_column cassiomarques/enumerate_it lwe/simple_enum novelys/static_list), description: ''},
  {name: 'ActiveRecord: Default Values for Attributes', lang: 'Ruby', repos: %w(), description: "There are various ways to set defaults for the objects created by a model. Next to the gems listed here they can be set in the database / database adapter using a Rails migration (as described here: [Rails Guides on Migrations](http://guides.rubyonrails.org/migrations.html). The community-driven [Rails Styleguide](https://github.com/bbatsov/rails-style-guide#migrations) recommends setting defaults in the model rather than a table."},
  {name: 'ActiveRecord: Data Migrations', lang: 'Ruby', repos: %w(soundcloud/large-hadron-migrator), description: ""},
  {name: 'ActiveRecord: Tagging, Marking, Liking & Rating', lang: 'Ruby', repos: %w(mbleigh/acts-as-taggable-on bradphelan/rocket_tag chrome/markable schneems/likeable leehambley/opinions peteonrails/vote_fu medihack/make_voteable twitter/activerecord-reputation-system vshvedov/vote_fu_rails_3 raw1z/amistad edgarjs/ajaxful-rating glynx/rateable ygor/acts_as_rateable sujitsagar/acts_as_rateable asceth/acts_as_rateable anton-zaytsev/acts_as_rateable), description: 'Tagging and marking for your ActiveRecord models.'},
  {name: 'ActiveRecord: Annotate Models', lang: 'Ruby', repos: %w(ctran/annotate_models), description: ""},
  {name: 'Admin Interfaces', lang: 'Ruby', repos: %w(sferik/rails_admin gregbell/active_admin fesplugas/typus bigbinary/admin_data ianmurrays/active_invoices fhwang/admin_assistant elia/activeadmin-mongoid renderedtext/admin_view tomas/bowtie kryzhovnik/rails_admin_tag_list dce/rails_admin_interfaces activescaffold/active_scaffold puffer/puffer acesuares/inline_forms codez/dry_crud joost/admin_interface), description: "Add an admin interface to your Rails app."},
  # API
  {name: 'API: API Builders', lang: 'Ruby', repos: %w(fabrik42/acts_as_api atomicobject/to_api), description: "Build an API for your application."},
  {name: 'API: XML Parsers & Builders', lang: 'Ruby', repos: %w(ohler55/ox sferik/multi_xml Empact/roxml jnunemaker/happymapper pauldix/sax-machine rubiii/gyoku mdub/representative michael-harrison/xml_active craigambrose/sax_stream soulcutter/saxerator sparklemotion/nokogiri), description: "SAX Parser = Simple API for XML Parser, event oriented parsing"},
  {name: 'API: XML Templating', lang: 'Ruby', repos: %w(nesquena/rabl jlong/radius), description: ""},

  # Apps
  {name: 'Apps: Content Management Systems (CMS)', lang: 'Ruby', repos: %w(radiant/radiant locomotivecms/engine resolve/refinerycms comfy/comfortable-mexican-sofa gma/nesta zena/zena quickleft/regulate puffer/puffer_pages browsermedia/browsercms DigitPaint/skyline hulihanapplications/Opal cantierecreativo/railsyardcms magiclabs/alchemy_cms gnuine/ubiquo spoiledmilk/casein3 zen-cms/zen-core fabiokr/manageable_content svenfuchs/adva-cms2), description: "Also have a look at our Frameworks: Static Site Generators section if you are intending to build a mostly view oriented website."},
  {name: 'Apps: Blogging Engines', lang: 'Ruby', repos: %w(imathis/octopress NateW/obtvse xaviershay/enki cloudhead/toto ruhoh/ruhoh.rb zbruhnke/bloggy galeki/chito middleman/middleman-blog browsermedia/bcms_blog KatanaCode/blogit hulihanapplications/Opal samsoffes/samsoff.es kiddsoftware/rails_blog_engine cloudhead/dorothy jipiboily/monologue judofyr/timeless fdv/typo hmans/schnitzelpress gma/nesta), description: ""},
  {name: 'Apps: Wikis', lang: 'Ruby', repos: %w(github/gollum sr/git-wiki dreverri/gollum-site), description: ""},
  {name: 'Apps: Forums & Social Network Building Blocks', lang: 'Ruby', repos: %w(radar/forem courtenay/altered_beast bborn/communityengine twitter/activerecord-reputation-system raw1z/amistad), description: ""},
  {name: 'Apps: Project Management & Organization', lang: 'Ruby', repos: %w(redmine/redmine chiliproject/chiliproject gitlabhq/gitlabhq malclocke/fulcrum ari/jobsworth jamesu/railscollab Bettermeans/bettermeans camelpunch/simply_agile kiskolabs/splendidbacon), description: ""},
  {name: 'Apps: Miscellaneous', lang: 'Ruby', repos: %w(janlelis/pws jamis/bucketwise mischa78/boxroom ugol/pomodoro visionmedia/pomo rapind/grokphoto), description: "Password Manager, Personal Finance Manager etc."},


  # B
  {name: 'Background Jobs', lang: 'Ruby', repos: %w(mperham/sidekiq mperham/girl_friday defunkt/resque collectiveidea/delayed_job ryandotsmith/queue_classic bkeepers/qu ruby-amqp/amqp), description: 'Process worker tasks in the background.'},
  {name: 'Background Jobs: Scheduling Jobs & Recurring Events', lang: 'Ruby', repos: %w(bvandenbos/resque-scheduler tomykaira/clockwork javan/whenever jmettraux/rufus-scheduler zencoder/recurrent seejohnrun/ice_cube), description: ""},

  # C
  # Coffeescript
  {name: 'Coffeescript: Guides / Styleguides', lang: 'JS', repos: %w(polarmobile/coffeescript-style-guide), description: ''},
  {name: 'Configuration: Configuration Objects', lang: 'Ruby', repos: %w(mbklein/confstruct GutenYe/optimism), description: ""},
  {name: 'Console: Frameworks for Console-Based Apps', lang: 'Ruby', repos: %w(koraktor/rubikon), description: ""},
  {name: 'Console: Managing Dotfiles', lang: 'Ruby', repos: %w(mattdbridges/dotify), description: ""},
  {name: 'Console: Alternative Command Line Shells', lang: 'Ruby/JS', repos: %w(fish-shell/fish-shell), description: ""},
  {name: 'Console: IRB Replacements', lang: 'Ruby', repos: %w(pry/pry cldwalker/hirb rweng/pry-rails nixme/pry-nav Mon-Ouie/pry-remote nixme/pry-debugger), description: ""},
  {name: 'Console: Terminal Automation', lang: 'Ruby', repos: %w(), description: ""},

  # D
  # Deployment
  {name: 'Deployment', lang: 'Ruby', repos: %w(opscode/rails-quick-start), description: ''},
  {name: 'Deployment: Webservers', lang: 'Ruby', repos: %w(macournoyer/thin rack/rack defunkt/unicorn puma/puma celluloid/reel postrank-labs/goliath zedshaw/mongrel2 ged/ruby-mongrel2 FooBarWidget/passenger), description: "Give Unicorn a try. There are also Rainbows! / Zbatery and others, each for specific kinds of apps."},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  # Development
  {name: 'Development: Editors', lang: 'Ruby/JS/Design', repos: %w(redcar/redcar adobe/brackets), description: ""},
  {name: 'Development: Development Webserver', lang: 'Ruby', repos: %w(37signals/pow rodreegez/powder), description: 'Automatically run your apps on your local machine, and access them with special domains in your browser.'},
  {name: 'Development: Development Machine Setup', lang: 'Ruby', repos: %w(atmos/smeagol thoughtbot/laptop oscardelben/RailsOneClick tokaido/tokaidoapp), description: 'Set up your laptop for Ruby or Rails development. http://www.rubypluspl.us/2012/06/ubuntu-1204-ruby-on-rails-development.html - Setting up ubuntu for RoR development.'},
  {name: 'Development: Manage Ruby Versions', lang: 'Ruby', repos: %w(wayneeseguin/rvm sstephenson/rbenv remear/jewelrybox ), description: 'Install the latest ruby builds on your laptop. You can also use different ruby versions on different projects.'},
  {name: 'Development: Routing', lang: 'Ruby', repos: %w(bjeanes/ghost 37signals/pow), description: ""},

  # E
  # E-Commerce
  {name: 'E-Commerce: Online Shops', lang: 'Ruby', repos: %w(spree/spree drhenner/ror_ecommerce Shopify/shopify_app Shopify/shopify_api), description: "Online store related gems."},
  {name: 'E-Commerce: Fulfillment & Shipping', lang: 'Ruby', repos: %w(Shopify/active_shipping spree/spree_active_shipping Shopify/active_fulfillment), description: "Online store related gems."},
  {name: 'E-Commerce: Payments & API Clients for Payment Processing Services', lang: 'Ruby', repos: %w(Shopify/active_merchant chargify/chargify_api_ares tylerhunt/remit rlivsey/rspreedly spreedly/spreedly-gem expectedbehavior/cheddargetter_client_ruby recurly/recurly-client-ruby fnando/paypal-recurring pengwynn/chargify nov/paypal-express braintree/braintree_ruby tc/paypal_adaptive stripe/stripe-ruby), description: "Get paid for your work. Includes Services that offer recurring subscription billing as well as one-time payments. Can handle credit card payments as well as paypal and other forms."},

  # F
  # Frameworks
  {name: 'Frameworks: Static Site Frameworks', lang: 'Ruby', repos: %w(mojombo/jekyll imathis/octopress middleman/middleman winton/stasis thoughtbot/high_voltage ddfreyne/nanoc blahed/frank sstephenson/brochure benschwarz/bonsai botanicus/ace ebello/Jekyll-S3 jamiew/heroku-static-site lukesutton/pekky plusjade/jekyll-bootstrap versapay/jekyll-s3 bmcmurray/hekyll petebrowne/machined cdn64/deplot dmathieu/glynn jlong/serve sinefunc/proton gma/nesta prose/prose prose/bootstrap migrs/rack-server-pages), description: "http://developmentseed.org/blog/2011/09/09/jekyll-github-pages/ - Using Jekyll and Github Pages for a Website"},
  {name: 'Frameworks: Web App Frameworks', lang: 'Ruby', repos: %w(rails/rails sinatra/sinatra padrino/padrino-framework Ramaze/ramaze lifo/cramp camping/camping), description: 'Build web applications easily with style.'},

  # Forms
  {name: 'Forms: Form Builders', lang: 'Ruby', repos: %w(justinfrench/formtastic plataformatec/simple_form ryanb/nested_form nathanvda/cocoon stouset/twitter_bootstrap_form_for JangoSteve/remotipart plataformatec/mail_form mjbellantoni/formtastic-bootstrap rafaelfranca/simple_form-bootstrap sethvargo/bootstrap_forms tizoc/bureaucrat springbok/smerf joshsusser/informal potenza/bootstrap_form ksylvest/formula jeremyevans/forme), description: "Generate markup for your forms easily. Please get familiar with the form building tools shipped with Rails first before contemplating to use any of the listed gems."},
  {name: 'Forms: File Uploading & Processing', lang: 'Ruby', repos: %w(JangoSteve/remotipart markevans/dragonfly mwilliams/d2s3 apeacox/simple_form_fancy_uploads jnicklas/carrierwave thoughtbot/paperclip dwilkie/carrierwave_direct mischa78/boxroom newbamboo/rack-raw-upload websymphony/Rails3-Paperclip-Uploadify camelpunch/ungulate jstorimer/delayed_paperclip igor-alexandrov/paperclip-aws dripster82/paperclipdropbox nhocki/paperclip-s3 kellym/mongoid_paperclip_queue ksylvest/attached technoweenie/attachment_fu), description: "Upload files, process them, and/or store them directly on a cloud storage service such as Amazon's S3."},
  {name: 'Forms: Client-Side Validation', lang: 'Ruby', repos: %w(bcardarella/client_side_validations amatsuda/html5_validators dockyard/client_side_validations-simple_form), description: "Automatically validate forms on the client side using Javascript or the latest HTML5 Validation Standards. Rules can be automatically extracted from the validations set in your model."},
  {name: 'Forms: Multi-Step Forms / Wizard Forms', lang: 'Ruby', repos: %w(schneems/wicked intridea/rails_wizard antonversal/stepper jeffp/wizardly RailsApps/rails_apps_composer), description: "Also consider the corresponding JS Plugins."},
  {name: 'Forms: Datepickers', lang: 'Ruby', repos: %w(kristianmandrup/ui_datepicker-rails3 albertopq/jquery_datepicker trentrichardson/jQuery-Timepicker-Addon), description: ""},
  {name: 'Forms: Email & Contact Forms', lang: 'Ruby', repos: %w(plataformatec/mail_form jdutil/contact_us eric1234/rack_mailer), description: "Also consider the ActiveAttr gem and the matching Railscasts episode."},
  {name: 'Forms: Spam Minimization', lang: 'Ruby', repos: %w(achiu/rack-recaptcha curtis/honeypot-captcha moowahaha/despamilator sinisterchipmunk/bot-away joshfrench/rakismet dvyjones/defender matthutchinson/acts_as_textcaptcha gutomcosta/simple-spam-filter), description: "Act on this problem only when it is a problem. Premature optimization is your enemy. Spam protection is often done using a single form field hidden by CSS rules that has to remain blank. If a value has been filled in and is sent along you know only a spam bot could have filled that form. Also take a look at the Javascript: Captchas and Spam Minimization section."},
  {name: 'Forms: Nested Forms', lang: 'Ruby', repos: %w(nathanvda/cocoon lailsonbm/awesome_nested_fields the-teacher/the_sortable_tree), description: ''},
  {name: 'Forms: Multi-Step Forms / Wizard Forms', lang: 'JS', repos: %w(wbotelhos/stepy kflorence/jquery-wizard thecodemine/formwizard dominicbarnes/jWizard mstratman/jQuery-Smart-Wizard), description: ""},

  # G
  {name: 'Git: Guides / Styleguides / Learning Git', lang: 'Ruby/JS', repos: %w(rogerdudler/git-guide blynn/gitmagic nvie/gitflow), description: ''},
  {name: 'Git: Accessing Git from Ruby', lang: 'Ruby/JS', repos: %w(mojombo/grit judofyr/gash schacon/ruby-git), description: ""},
  {name: 'Git: Self-Hosted Git Servers', lang: 'Ruby/JS', repos: %w(gitlabhq/gitlabhq toolmantim/bananajour), description: ""},
  {name: 'Git: Apps / GUIs', lang: 'Ruby/JS', repos: %w(Caged/gitnub), description: ""},
  {name: 'Git: Commit Messages', lang: 'Ruby/JS', repos: %w(mroth/lolcommits), description: ""},
  {name: 'Git: Flow Model & Scripts', lang: 'Ruby/JS', repos: %w(jwiegley/git-scripts nvie/gitflow), description: ""},

  # H
  {name: 'Hash Extensions', lang: 'Ruby', repos: %w(intridea/hashie svenfuchs/hashr ahoward/map delano/gibbler ismasan/hash_mapper rubyworks/hashery), description: ""},
  {name: 'HTTP: Consoles', lang: 'Ruby', repos: %w(htty/htty), description: ""},
  {name: 'HTTP: Clients', lang: 'Ruby', repos: %w(typhoeus/typhoeus deepfryed/http-parser-lite c42/wrest), description: "Consume APIs and web services."},


  # I


  {name: 'Launch Pages', lang: 'Ruby', repos: %w(carmivore/comingsoon), description: "Landing Pages & Email Signup pages."},
  {name: 'Tagging', lang: 'JS', repos: %w(ivaynberg/select2), description: ""},
  {name: 'Selects', lang: 'JS', repos: %w(ivaynberg/select2 harvesthq/chosen), description: ""},
  {name: 'Async Image Loaders', lang: 'JS', repos: %w(sebarmeli/JAIL), description: ""},
  {name: 'Syntax Highlighting', lang: 'JS', repos: %w(ccampbell/rainbow), description: ""},
  {name: 'Mobile: Phonegap', lang: 'JS/Design', repos: %w(davebalmer/jo), description: ""},
  {name: 'Optimizing: Performance Monitoring', lang: 'Ruby', repos: %w(newrelic/rpm), description: ""},
  {name: 'Database: Migrations', lang: 'Ruby', repos: %w(thuss/standalone-migrations), description: "Use the power of Rails Migrations for Non-Rails (and even Non-Ruby) Projects."},
  {name: 'Asset Pipeline', lang: 'Ruby', repos: %w(evrone/quiet_assets), description: "Mute asset pipeline log messages and more."},
  {name: 'Placeholders', lang: 'JS/Design', repos: %w(imsky/holder), description: ""},
  {name: 'CI', lang: 'JS', repos: %w(ryankee/concrete), description: ""},
  {name: 'Chat Servers', lang: 'Ruby/JS', repos: %w(negativecode/vines gravityonmars/Balloons.IO), description: ""},
  {name: 'Email: Backup', lang: 'Ruby', repos: %w(rgrove/larch), description: ""},
  {name: 'Oauth Servers', lang: 'Ruby', repos: %w(Lelylan/rest-oauth2-server nov/rack-oauth2 assaf/rack-oauth2-server rubycas/rubycas-server), description: ""},
  {name: 'API Builders & Servers', lang: 'JS', repos: %w(kilianc/node-apiserver), description: ""},
  {name: 'Development: Webservers', lang: 'Ruby', repos: %w(37signals/pow pyromaniac/hoof rtomayko/shotgun puma/puma-express jc00ke/guard-puma), description: ""},
  {name: 'Websockets', lang: 'Ruby', repos: %w(igrigorik/em-websocket gimite/web-socket-ruby), description: ""},
  {name: 'jQuery on Server', lang: 'JS', repos: %w(MatthewMueller/cheerio), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},
  {name: '', lang: 'Ruby', repos: %w(), description: ""},


  # J

  # K
  {name: 'Key-Value Stores: Redis: Clients', lang: 'Ruby', repos: %w(redis/redis-rb), description: ""},

  # L
  {name: 'Learning Rails', lang: 'Ruby', repos: %w(devalot/ror-example), description: 'Getting better in Rails development every day is considered a noble cause. http://railsapps.github.com/rails.html - Resources on Learning Rails'},
  {name: 'Learning Ruby', lang: 'Ruby', repos: %w(JoshCheek/ruby-kickstart the-teacher/Ruby-Lessons edgecase/ruby_koans), description: 'Get better in Ruby development every day is something to live by.'},
  {name: 'Learning Ruby - Advanced', lang: 'Ruby', repos: %w(raganwald/homoiconic), description: ""},

  # M
  {name: 'Mongoid: Plugins', lang: 'Ruby', repos: %w(aq1018/mongoid-history hakanensari/mongoid-slug), description: ''},
  {name: 'Metrics: Event Logging & Aggregation / Exception Tracking & Stats Servers', lang: 'Ruby', repos: %w(paulasmuth/fnordmetric dcramer/sentry noahhl/batsd Fudge/gltail), description: ""},
  {name: 'Mobile: Android Development', lang: 'Ruby', repos: %w(ruboto/ruboto), description: ""},

  # N
  {name: 'Node: Guides / Styleguides', lang: 'JS', repos: %w(felixge/nodeguide.com), description: ''},

  # O
  {name: 'Office Radio', lang: 'Ruby', repos: %w(play/play), description: "Music makes the heart shine."},
  # Optimizing
  {name: 'Optimizing: Split Testing / A/B Testing', lang: 'Ruby', repos: %w(xing/absurdity andrew/split assaf/vanity jhubert/rails-split-tester hayesgm/mountain_goat), description: 'Optimizing your website conversion rates can include A/B-Testing, Split Testing, Multivariate Testing, and more. Test your assumptions to see what is not working and what is.'},
  {name: 'Optimizing: Split Testing / A/B Testing', lang: 'JS', repos: %w(jamesyu/cohorts grippy/node-multivariate thumbtack/abba jgallen23/dice-roll), description: 'Optimizing your website conversion rates can include A/B-Testing, Split Testing, Multivariate Testing, and more. Test your assumptions to see what is not working and what is.'},
  {name: 'Optimizing: Stylesheets', lang: 'Ruby', repos: %w(aanand/deadweight), description: ""},
  {name: 'Optimizing: Code Quality Metrics', lang: 'Ruby', repos: %w(railsbp/rails_best_practices), description: ""},
  {name: 'Optimizing: Database Queries & Structure', lang: 'Ruby', repos: %w(flyerhzm/bullet nesquena/query_reviewer eladmeidar/rails_indexes), description: ""},
  {name: 'Optimizing: Log Analysis & Aggregation', lang: 'Ruby', repos: %w(wvanbergen/request-log-analyzer), description: ""},
  {name: 'Optimizing: Caching', lang: 'Ruby', repos: %w(Arjeno/catche), description: ""},

  {name: 'Other Languages / Frameworks: Guides / Styleguides', lang: 'Ruby/JS', repos: %w(oreilly/couchdb-guide), description: ''},
  {name: 'ORMs: Key-Value Stores', lang: 'Ruby', repos: %w(technoweenie/horcrux jnunemaker/toystore), description: ""},
  {name: 'ORMs: MongoDB', lang: 'Ruby', repos: %w(mongoid/mongoid jnunemaker/mongomapper), description: ""},
  {name: 'ORMs: MySQL', lang: 'Ruby', repos: %w(jeremyevans/sequel datamapper/dm-core), description: "ActiveRecord"},


  # P
  {name: 'Parsers: CSV', lang: 'Ruby', repos: %w(seamusabshere/data_miner), description: ''},
  {name: 'Parsers: HTML & Sanitizers', lang: 'Ruby', repos: %w(sparklemotion/nokogiri flavorjones/loofah), description: ''},
  {name: 'Parsers: JSON', lang: 'Ruby', repos: %w(ohler55/oj intridea/multi_json flori/json brianmario/yajl-ruby jnunemaker/crack kr/okjson), description: ''},
  {name: 'Parsers: Markdown', lang: 'Ruby', repos: %w(tanoku/redcarpet tanoku/sundown rtomayko/rdiscount github/github-flavored-markdown vigetlabs/acts_as_markup gettalong/kramdown postmodern/multi_markdown jgarber/redcloth), description: ""},
  {name: 'Parsers: XLS', lang: 'Ruby', repos: %w(seamusabshere/data_miner), description: ''},
  {name: 'Parsers: XML', lang: 'Ruby', repos: %w(jnunemaker/crack rubiii/nori sparklemotion/nokogiri flavorjones/loofah jnunemaker/happymapper seamusabshere/data_miner), description: ''},
  {name: 'Parsers: Natural Language Dates', lang: 'Ruby', repos: %w(mojombo/chronic hpoydar/chronic_duration), description: ""},
  {name: 'Presentations', lang: 'Ruby/JS', repos: %w(bmcmurray/hekyll ), description: ""},
  {name: 'Process Management', lang: 'Ruby', repos: %w(ddollar/foreman), description: ""},
  {name: 'Prototyping', lang: 'Ruby', repos: %w(jlong/serve mhs/scout-app), description: ""},

  # Q

  # R
  # Rails
  {name: 'Rails: Bootstrap your project', lang: 'Ruby', repos: %w(jeriko/app_drone RailsApps/rails_apps_composer RailsApps/rails3-application-templates kfaustino/rails-templater renderedtext/base-app intridea/rails_wizard dfischer/Rails-3-Quickstart-Compass--Haml--Sass--SCSS russfrisch/h5bp-rails greendog99/greendog-rails-template cwsaylor/rails3-quickstart), description: "Rails App Generators and Templates. Get you off the ground quickly by bringing in sensible defaults. Templates, Blueprints, Project Generators"},
  {name: 'Rails: Generators for Popular Gems', lang: 'Ruby', repos: %w(ryanb/nifty-generators indirect/rails3-generators leogalmeida/slim-rails indirect/haml-rails), description: ""},
  # Routing
  {name: 'Routing: Subdomains', lang: 'Ruby', repos: %w(RailsApps/rails3-subdomains mbleigh/subdomain-fu), description: "Working with Subdomains got much easier in Rails 3.1+. Take a look at the Rails Guide [Rails Routing from the Outside in](http://guides.rubyonrails.org/routing.html)."},
  {name: 'Routing: FriendlyId & Routing', lang: 'Ruby', repos: %w(svenfuchs/routing-filter), description: "Also take a look at our ActiveRecord: FriendlyId section."},


  # S
  {name: 'Security: Uncover Vulnerabilities', lang: 'Ruby', repos: %w(presidentbeef/brakeman), description: ""},
  {name: 'Statistics', lang: 'Ruby', repos: %w(thirtysixthspan/descriptive_statistics), description: ''},
  # Styling
  {name: 'Styling: CSS Preprocessors', lang: 'Ruby/Design', repos: %w(nex3/sass chriseppstein/compass cowboyd/less.rb cloudhead/less.js), description: "Still writing plain CSS? Consider using SASS, Less, Stylus or any other preprocessor. They generally give you advanced features like variables, mixins, color functions and more. For some of them there are great mixin libraries available."},
  {name: 'Styling: Design Frameworks', lang: 'Design/Ruby', repos: %w(twitter/bootstrap zurb/foundation h5bp/html5-boilerplate necolas/normalize.css joshuaclayton/blueprint-css), description: "Build great looking websites with ease."},
  {name: 'Styling: Sass: Mixin Libraries', lang: 'Ruby/Design', repos: %w(thoughtbot/bourbon), description: ""},
  {name: 'Styling: Sprite Generators', lang: 'Ruby/Design', repos: %w(jakesgordon/sprite-factory), description: ""},
  {name: 'Speach: Making Ruby Speak', lang: 'Ruby', repos: %w(ruby-talks/talks), description: ""},
  {name: 'Speach: Siri Proxies', lang: 'Ruby', repos: %w(plamoni/SiriProxy), description: ""},


  # T
  {name: 'Templating: PDF Generators', lang: 'Ruby', repos: %w(mbleigh/princely fnando/kitabu), description: ''},
  {name: 'Templating: JSON', lang: 'Ruby', repos: %w(nesquena/rabl fabrik42/acts_as_api), description: ''},
  {name: 'Templating: XML', lang: 'Ruby', repos: %w(nesquena/rabl fabrik42/acts_as_api), description: ''},
  {name: 'Testing: Build Systems & Continuous Integration', lang: 'Ruby', repos: %w(travis-ci/travis-ci defunkt/cijoe github/janky jenkinsci/jenkins.rb c42/goldberg), description: ""},

  # U
  {name: 'User Management: Authentication', lang: 'Ruby', repos: %w(plataformatec/devise NoamB/sorcery thoughtbot/clearance intridea/omniauth), description: 'Authenticate your users.'},
  {name: 'User Management: Authorization', lang: 'Ruby', repos: %w(ryanb/cancan stffn/declarative_authorization kristianmandrup/cantango EppO/rolify platform45/easy_roles nathanl/authority james2m/canard mcrowe/roleable the-teacher/the_role), description: 'Manage user roles and abilities. There are various concepts when it come to Authorization.'},
  {name: 'UUID Generators', lang: 'Ruby', repos: %w(assaf/uuid ryanking/simple_uuid jashmenn/activeuuid sporkmonger/uuidtools norbert/has_uuid), description: ""},

  # V
  {name: 'Views: Calendar Helpers', lang: 'Ruby', repos: %w(topfunky/calendar_helper), description: ""},
  {name: 'Views: Table Builders', lang: 'Ruby', repos: %w(provideal/tabulatr watu/table_builder jgdavey/tabletastic tokumine/fusion_tables pluginaweek/table_helper lunich/table_for), description: "Render table with searching and sorting helpers."},
  {name: 'Views: Tabs', lang: 'Ruby', repos: %w(weppos/tabs_on_rails), description: ""},
  {name: 'Views: Templating Engines & Languages', lang: 'Ruby', repos: %w(haml/haml stonean/slim Shopify/liquid rtomayko/tilt defunkt/mustache markaby/markaby blambeau/wlang), description: "Tired of <html>? Try slim and companions."},

  # W
  {name: 'WYSIWYG Editors', lang: 'Ruby', repos: %w(jejacks0n/mercury kete/tiny_mce bastiaanterhorst/rich), description: ""},

  # X

  # Y

  # Z

  # 123



  # JS
  {name: 'Clipboard', lang: 'JS', repos: %w(mojombo/clippy), description: ""},
  {name: 'Context Menus', lang: 'JS', repos: %w(medialize/jQuery-contextMenu), description: ""},
  {name: 'Interface Toolkits', lang: 'JS/Design/Ruby', repos: %w(visionmedia/uikit necolas/suit), description: ""},
  {name: 'Tables & Editable Tables', lang: 'JS', repos: %w(warpech/jquery-handsontable JangoSteve/jquery-dynatable), description: ""},
  {name: 'Tabs', lang: 'JS', repos: %w(JangoSteve/jQuery-EasyTabs), description: ""},

  # Design
  {name: 'Buttons', lang: 'Design', repos: %w(michenriksen/css3buttons thetron/css3buttons_rails_helpers necolas/css3-github-buttons ubuwaits/css3-buttons), description: ""},
  {name: 'Styling: Styleguides', lang: 'Design/Ruby/JS', repos: %w(necolas/idiomatic-css csswizardry/CSS-Guidelines), description: 'Write consistent and maintainable view files. Book recommendation: The Rails View, Pragmatic Programmers.'},


  {name: 'Rails: Project Generators & Templates', lang: 'Ruby', repos: %w(), description: 'Get your project off the ground with ease.'},
  {name: 'Icon Fonts', lang: 'Design', repos: %w(FortAwesome/Font-Awesome pfefferle/openwebicons zurb/foundation-icons), description: 'Icon fonts are the new way to get icons on a website. Advantages over image files: Scalable to every size because they are vectorised; Most CSS3 Properties are available: Shadows, Borders etc. Color can be changed freely.'},
  {name: 'Ruby: Guides / Styleguides', lang: 'Ruby', repos: %w(bbatsov/rails-style-guide bbatsov/ruby-style-guide copycopter/style-guide davetron5000/ruby-style), description: 'Write maintainable ruby code.'},
  {name: 'Twitter API Clients', lang: 'Ruby', repos: %w(intridea/tweetstream jnunemaker/twitter sferik/t jugyo/earthquake marcel/twurl twitter/twitter-text-rb voloko/twitter-stream seejohnrun/console_tweet), description: 'API Wrappers for Twitter.'},
  {name: 'Rubies', lang: 'Ruby', repos: %w(ruby/ruby mruby/mruby jruby/jruby rubinius/rubinius), description: 'Ruby Implementations.'},
  {name: 'Collaboration: Source Code Management', lang: 'Ruby/JS', repos: %w(gitlabhq/gitlabhq), description: 'Version Control for your code.'},
  {name: 'Collaboration / Project Management',lang: 'Ruby/JS', repos: %w(teambox/teambox), description: 'Team collaboration.'},
  {name: 'Rails App Tutorials', lang: 'Ruby', repos: %w(RailsApps/rails3-bootstrap-devise-cancan sferik/sign-in-with-twitter RailsApps/rails-prelaunch-signup RailsApps/rails3-mongoid-omniauth RailsApps/rails3-mongoid-devise RailsApps/rails3-bootstrap-devise-cancan RailsApps/rails3-devise-rspec-cucumber RailsApps/rails3-subdomains), description: 'Example apps and tutorials.'},
  {name: 'Textmate and Sublime Text Snippets', lang: 'Ruby/JS/Design', repos: %w(devtellect/sublime-twitter-bootstrap-snippets), description: 'Code Editor snippets. Mostly Textmate and Sublime Text. You can generally use Textmate Plugins in Sublime Text 2.'},
  {name: 'Twitter Bootstrap for Rails', lang: 'Ruby/Design', repos: %w(mjbellantoni/formtastic-bootstrap rafaelfranca/simple_form-bootstrap sethvargo/bootstrap_forms  metaskills/less-rails-bootstrap anjlab/bootstrap-rails yabawock/bootstrap-sass-rails xdite/bootstrap-helper yrgoldteeth/bootstrap-will_paginate decioferreira/bootstrap-generators pusewicz/twitter-bootstrap-markup-rails thomaspark/bootswatch anjlab/bootstrap-rails markdotto/bootstrap-university), description: 'Helpers for using Twitter Bootstrap with Rails.'},
  {name: 'Web Design Elements', lang: 'Design', repos: %w(todc/css3-google-buttons necolas/normalize.css necolas/css3-github-buttons michenriksen/css3buttons), description: 'Buttons, Form Styles, Cross-Browser Styles etc.'},
]

# Plugins
# {parent: '', children: %w()},

plugins = [
  {parent: 'twitter/bootstrap', children: %w(seyhunak/twitter-bootstrap-rails thomas-mcdonald/bootstrap-sass)}
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

puts 'Writing Plugins...'

# Write Plugins
plugins.each do |plugin|
  plugin[:children].each do |child_full_name|
    repo = Repo.find_or_initialize_by_full_name(child_full_name)
    parents = repo.parent_list.split(', ')
    parents << plugin[:parent]
    repo.parent_list = parents.join(', ')
    repo.save
  end
end

puts "Running 'Updater.update_repos_from_github'."
Updater.update_repos_from_github

puts "Running 'Updater.update_categories_from_repos'."
Updater.update_categories_from_repos

puts 'Finished writing seeds successfully.'