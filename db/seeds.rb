# ruby encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# Empty Items List:    {name: '', lang: 'Ruby', repos: %w(ernie/ransack ernie/squeel rails/arel ernie/meta_search ernie/meta_where wvanbergen/scoped_search novagile/scoped-search), description: ""},
#
# Be sure to respect mass assignment protection!

puts 'Processing Seeds. Check log for progress...'

# Build seeds
seeds = [
  {name: 'ActiveRecord: Searching', lang: 'Ruby', repos: %w(ernie/squeel rails/arel binarylogic/searchlogic ernie/ransack wvanbergen/scoped_search novagile/scoped-search pioz/ximate sunspot/sunspot freelancing-god/thinking-sphinx karmi/tire mwmitchell/rsolr ryanb/xapit texticle/texticle jkraemer/acts_as_ferret  Casecommons/pg_search huacnlee/redis-search wvanbergen/scoped_search garaio/xapian_db dougal/acts_as_indexed grantr/rubberband), description: "Full-Text Searching."},
  {name: 'ActiveRecord: Scopes', lang: 'Ruby', repos: %w(ernie/ransack ernie/squeel rails/arel ernie/meta_search ernie/meta_where wvanbergen/scoped_search novagile/scoped-search), description: "Scopes represent narrowings of a database query. Named scopes help organize these filters."},
  {name: 'ActionMailer: Email Previews', lang: 'Ruby', repos: %w(37signals/mail_view ryanb/letter_opener sj26/mailcatcher), description: "Preview the Emails you would be sending in your development environment instead of actually sending them."},
  {name: 'Administration Interfaces', lang: 'Ruby', repos: %w(sferik/rails_admin gregbell/active_admin fesplugas/typus bigbinary/admin_data ianmurrays/active_invoices fhwang/admin_assistant elia/activeadmin-mongoid renderedtext/admin_view tomas/bowtie kryzhovnik/rails_admin_tag_list dce/rails_admin_interfaces activescaffold/active_scaffold puffer/puffer acesuares/inline_forms codez/dry_crud joost/admin_interface), description: "Administration Frameworks for Rails apps."},
  {name: 'Background Jobs', lang: 'Ruby', repos: %w(nesquena/backburner mperham/sidekiq mperham/girl_friday defunkt/resque collectiveidea/delayed_job ryandotsmith/queue_classic bkeepers/qu ruby-amqp/amqp), description: "Background jobs are key to building truly scalable web apps as they transfer both time and computationally intensive tasks from the web layer to a background process outside the user request/response lifecycle."},
  {name: 'Background Jobs: Scheduling Jobs & Recurring Events', lang: 'Ruby', repos: %w(bvandenbos/resque-scheduler tomykaira/clockwork javan/whenever jmettraux/rufus-scheduler zencoder/recurrent seejohnrun/ice_cube), description: "Schedule recurring work at particular Times or Dates. Cron for Ruby."},
  {name: 'Apps: Content Management Systems', lang: 'Ruby', repos: %w(radiant/radiant locomotivecms/engine resolve/refinerycms comfy/comfortable-mexican-sofa gma/nesta zena/zena quickleft/regulate puffer/puffer_pages browsermedia/browsercms DigitPaint/skyline hulihanapplications/Opal cantierecreativo/railsyardcms magiclabs/alchemy_cms gnuine/ubiquo spoiledmilk/casein3 zen-cms/zen-core fabiokr/manageable_content svenfuchs/adva-cms2), description: "A Content Management System (CMS) provides content authoring and adminstration tools to allow users with little knowledge of programming languages to edit a website's contents with relative ease."},
  {name: 'Apps: Blogging Engines', lang: 'Ruby', repos: %w(imathis/octopress NateW/obtvse xaviershay/enki cloudhead/toto ruhoh/ruhoh.rb zbruhnke/bloggy galeki/chito middleman/middleman-blog browsermedia/bcms_blog KatanaCode/blogit hulihanapplications/Opal samsoffes/samsoff.es kiddsoftware/rails_blog_engine cloudhead/dorothy jipiboily/monologue judofyr/timeless fdv/typo hmans/schnitzelpress gma/nesta), description: "No need to explain Blogging, is there?"},
  {name: 'Frameworks: Web Apps', lang: 'Ruby', repos: %w(rails/rails sinatra/sinatra padrino/padrino-framework Ramaze/ramaze lifo/cramp camping/camping slivu/presto soveran/cuba), description: "Web App Frameworks give you a lot of tools to speed you up with web development."},
  {name: 'Frameworks: Static Sites', lang: 'Ruby', repos: %w(mojombo/jekyll imathis/octopress middleman/middleman winton/stasis thoughtbot/high_voltage ddfreyne/nanoc blahed/frank sstephenson/brochure benschwarz/bonsai botanicus/ace ebello/Jekyll-S3 jamiew/heroku-static-site lukesutton/pekky plusjade/jekyll-bootstrap versapay/jekyll-s3 bmcmurray/hekyll petebrowne/machined cdn64/deplot dmathieu/glynn jlong/serve sinefunc/proton gma/nesta prose/prose prose/bootstrap migrs/rack-server-pages), description: "Build & Design a site in your favorite templating language and using CSS and JS preprocessors. Serve the compiled static HTML, CSS & JS."},
  {name: 'Forms: Form Builders', lang: 'Ruby', repos: %w(justinfrench/formtastic plataformatec/simple_form ryanb/nested_form nathanvda/cocoon stouset/twitter_bootstrap_form_for JangoSteve/remotipart plataformatec/mail_form mjbellantoni/formtastic-bootstrap rafaelfranca/simple_form-bootstrap sethvargo/bootstrap_forms tizoc/bureaucrat springbok/smerf joshsusser/informal potenza/bootstrap_form ksylvest/formula jeremyevans/forme Manfred/Shaper), description: "Form Builders let you generate complex forms with simple markup."},
  {name: 'Forms: File Uploads', lang: 'Ruby', repos: %w(JangoSteve/remotipart markevans/dragonfly mwilliams/d2s3 apeacox/simple_form_fancy_uploads jnicklas/carrierwave thoughtbot/paperclip mischa78/boxroom newbamboo/rack-raw-upload camelpunch/ungulate ksylvest/attached technoweenie/attachment_fu thoughtbot/jack_up), description: "Upload files to your app or a cloud storage service such as Amazon S3. Process images and videos on-thy-fly."},
  {name: 'Users: Authentication', lang: 'Ruby', repos: %w(plataformatec/devise NoamB/sorcery thoughtbot/clearance intridea/omniauth binarylogic/authlogic intridea/oauth2 moomerman/twitter_oauth arsduo/koala), description: "User authentication is required in almost every application."},
  {name: 'Users: Authorization', lang: 'Ruby', repos: %w(ryanb/cancan stffn/declarative_authorization kristianmandrup/cantango EppO/rolify platform45/easy_roles nathanl/authority james2m/canard mcrowe/roleable the-teacher/the_role Fingertips/authorization-san), description: "Restrict what resources a user is allowed to access."},
  {name: 'Ruby Implementations', lang: 'Ruby', repos: %w(ruby/ruby mruby/mruby jruby/jruby rubinius/rubinius), description: 'Implementations of the Ruby Language for a variety of platforms and use cases.'},

=begin
  # A
  # ActionMailer
  {name: 'ActionMailer: Email Templating', lang: 'Ruby', repos: %w(plataformatec/markerb judofyr/temple), description: "Templating Engines for ActionMailer Emails."},
  # ActiveRecord
  {name: 'ActiveRecord: Soft Deleting', lang: 'Ruby', repos: %w(radar/paranoia goncalossilva/rails3_acts_as_paranoid JackDanger/permanent_records teambox/immortal expectedbehavior/acts_as_archival nay/never_wastes socialcast/delete_paranoid), description: 'Prevent your destroyed objects from getting deleted from the database.'},
  {name: 'ActiveRecord: Versioning, Auditing & History Tracking', lang: 'Ruby', repos: %w(collectiveidea/audited harleyttd/auditable airblade/paper_trail technoweenie/acts_as_versioned jmckible/version_fu bdurand/acts_as_revisionable Tapjoy/acts_as_approvable Sigiz/record_history seejohnrun/track_history nearinfinity/auditor laserlemon/vestal_versions), description: "Track changes to your model's data. Related: [ActiveModel Dirty Objects](http://api.rubyonrails.org/classes/ActiveModel/Dirty.html) helps keeping track of the changes to an object before it is being saved."},
  {name: 'ActiveRecord: Lists & Sortable Columns', lang: 'Ruby', repos: %w(swanandp/acts_as_list the-teacher/the_sortable_tree dadooda/handles_sortable_columns 12spokes/acts_as_restful_list codegram/resort mixonic/ranked-model shuber/sortable bogdan/datagrid thoughtbot/sortable_table), description: 'Related: [ActiveRecord: Nesting](#)'},
  {name: 'ActiveRecord: Nesting', lang: 'Ruby', repos: %w(collectiveidea/awesome_nested_set mceachen/closure_tree amerine/acts_as_tree ryanb/nested_form stefankroes/ancestry elight/acts_as_commentable_with_threading the-teacher/the_sortable_tree clyfe/acts_as_nested_interval amatsuda/nested_scaffold thinkwell/mongoid_nested_set svenfuchs/simple_nested_set bkuhlmann/lineage), description: "The nested set model is a particular technique for representing nested sets (also known as trees or hierarchies) in relational databases."},
  {name: 'ActiveRecord: Normalizing', lang: 'Ruby', repos: %w(holli/auto_strip_attributes rmm5t/strip_attributes mdeering/attribute_normalizer), description: "Normalize and escape user input before saving. Also take a look at Ruby's 'strip' method and Rails' built-in 'squish' method ('Returns the string, first removing all whitespace on both ends of the string, and then changing remaining consecutive whitespace groups into one space each.' - Rails API Docs. Also take a look at the Parsers: HTML Sanitization section. Value Cleanup / Attribute Stripping / Attribute Normalizing"},
  {name: 'ActiveRecord: Enumerations & State-Machines', lang: 'Ruby', repos: %w(svenfuchs/simple_states pluginaweek/state_machine twinslash/enumerize yonbergman/enumify beerlington/classy_enum electronick/enum_column cassiomarques/enumerate_it lwe/simple_enum novelys/static_list), description: ''},
  {name: 'ActiveRecord: Default Values for Attributes', lang: 'Ruby', repos: %w(), description: "There are various ways to set defaults for the objects created by a model. Next to the gems listed here they can be set in the database / database adapter using a Rails migration (as described here: [Rails Guides on Migrations](http://guides.rubyonrails.org/migrations.html). The community-driven [Rails Styleguide](https://github.com/bbatsov/rails-style-guide#migrations) recommends setting defaults in the model rather than a table."},
  {name: 'ActiveRecord: Data Migrations', lang: 'Ruby', repos: %w(soundcloud/large-hadron-migrator portablemind/data_migrator), description: ""},
  {name: 'ActiveRecord: Tagging / Marking / Liking & Rating', lang: 'Ruby', repos: %w(mbleigh/acts-as-taggable-on bradphelan/rocket_tag chrome/markable schneems/likeable leehambley/opinions peteonrails/vote_fu medihack/make_voteable twitter/activerecord-reputation-system vshvedov/vote_fu_rails_3 raw1z/amistad edgarjs/ajaxful-rating glynx/rateable ygor/acts_as_rateable sujitsagar/acts_as_rateable asceth/acts_as_rateable anton-zaytsev/acts_as_rateable), description: 'Tagging and marking for your ActiveRecord models.'},
  {name: 'ActiveRecord: Annotate Models', lang: 'Ruby', repos: %w(ctran/annotate_models), description: "Print table schemas."},
  {name: 'ActiveRecord: Misc', lang: 'Ruby', repos: %w(activescaffold/active_scaffold codez/dry_crud metaskills/store_configurable robertwahler/dynabix), description: ""},
  {name: 'ActiveRecord: Seeds', lang: 'Ruby', repos: %w(mbleigh/seed-fu rhalff/seed_dump sevenwire/bootstrapper james2m/seedbank simonc/versioned_seeds developer357/seeds midas/genesis innku/seedsv markmcspadden/seed_me kevTheDev/seed_dumper), description: "http://railscasts.com/episodes/179-seed-data http://www.ruby-auf-schienen.de/buch/seed_rb.html (in German)"},
  {name: 'ActiveRecord: Pagination & Sorting', lang: 'Ruby', repos: %w(mislav/will_paginate amatsuda/kaminari mynameisrufus/sorted ronalchn/ajax_pagination provideal/tabulatr hiteshrawal/sortable godfat/pagify Fingertips/peiji-san leikind/wice_grid bkuhlmann/sorter), description: ""},
  {name: 'ActiveRecord: Friendly Ids', lang: 'Ruby', repos: %w(norman/friendly_id bkuhlmann/tokener bumi/find_by_param), description: ""},
  # API
  {name: 'API: API Builders', lang: 'Ruby', repos: %w(intridea/grape filtersquad/rocket_pants LTe/grape-rabl spastorino/rails-api bploetz/versionist filtersquad/api_smith mloughran/api_cache lyonrb/biceps vigetlabs/serialize_with_options fnando/rack-api fabrik42/acts_as_api atomicobject/to_api), description: "Build an API for your application."},
  {name: 'API: XML Parsers & Builders', lang: 'Ruby', repos: %w(ohler55/ox sferik/multi_xml Empact/roxml jnunemaker/happymapper pauldix/sax-machine rubiii/gyoku mdub/representative michael-harrison/xml_active craigambrose/sax_stream soulcutter/saxerator sparklemotion/nokogiri), description: "SAX Parser = Simple API for XML Parser, event oriented parsing"},
  {name: 'API: XML Templating', lang: 'Ruby', repos: %w(nesquena/rabl jlong/radius), description: ""},
  # Apps
  {name: 'Apps: Wikis', lang: 'Ruby', repos: %w(github/gollum sr/git-wiki dreverri/gollum-site), description: ""},
  {name: 'Apps: Forums & Social Network Building Blocks', lang: 'Ruby', repos: %w(radar/forem courtenay/altered_beast bborn/communityengine twitter/activerecord-reputation-system raw1z/amistad), description: ""},
  {name: 'Apps: Project Management & Organization', lang: 'Ruby', repos: %w(redmine/redmine chiliproject/chiliproject gitlabhq/gitlabhq malclocke/fulcrum ari/jobsworth jamesu/railscollab Bettermeans/bettermeans camelpunch/simply_agile kiskolabs/splendidbacon), description: ""},
  {name: 'Apps: Miscellaneous', lang: 'Ruby', repos: %w(janlelis/pws jamis/bucketwise mischa78/boxroom ugol/pomodoro visionmedia/pomo rapind/grokphoto), description: "Password Manager, Personal Finance Manager etc."},
  {name: 'Asset Pipeline', lang: 'Ruby', repos: %w(evrone/quiet_assets), description: "Mute asset pipeline log messages and more."},
  # B

  # C
  {name: 'Chat Servers', lang: 'JS/Ruby', repos: %w(negativecode/vines gravityonmars/Balloons.IO), description: ""},
  {name: 'Charts & Graphs', lang: 'Ruby', repos: %w(topfunky/gruff), description: ""},
  # Coffeescript
  {name: 'Coffeescript: Guides / Styleguides', lang: 'JS', repos: %w(polarmobile/coffeescript-style-guide), description: ''},
  {name: 'Configuration: Configuration Objects', lang: 'Ruby', repos: %w(mbklein/confstruct GutenYe/optimism), description: ""},
  {name: 'Console: Frameworks for Console-Based Apps', lang: 'Ruby', repos: %w(koraktor/rubikon), description: ""},
  {name: 'Console: Managing Dotfiles', lang: 'Ruby', repos: %w(mattdbridges/dotify), description: ""},
  {name: 'Console: Alternative Command Line Shells', lang: 'Ruby/JS', repos: %w(fish-shell/fish-shell), description: ""},
  {name: 'Console: IRB Replacements', lang: 'Ruby', repos: %w(pry/pry cldwalker/hirb codegram/rack-webconsole blackwinter/brice ileitch/hijack), description: ""},
  {name: 'Console: Terminal Automation', lang: 'Ruby', repos: %w(), description: ""},

  # D
  {name: 'Database: Structure & Data Migrations', lang: 'Ruby', repos: %w(thuss/standalone-migrations), description: "Use the power of Rails Migrations for Non-Rails (and even Non-Ruby) Projects."},
  {name: 'Database: Seeds', lang: 'Ruby', repos: %w(mbleigh/seed-fu rhalff/seed_dump sevenwire/bootstrapper james2m/seedbank simonc/versioned_seeds developer357/seeds midas/genesis innku/seedsv markmcspadden/seed_me kevTheDev/seed_dumper), description: "http://railscasts.com/episodes/179-seed-data http://www.ruby-auf-schienen.de/buch/seed_rb.html (in German)"},
  {name: 'Database: Cleaning', lang: 'Ruby', repos: %w(bmabey/database_cleaner), description: ""},
  {name: 'Database: Management Tools', lang: 'Ruby', repos: %w(tumblr/jetpants), description: ""},
  {name: 'Database: Backups', lang: 'Ruby', repos: %w(meskyanichi/backup yob/db2fog), description: ""},
  # Deployment
  {name: 'Deployment', lang: 'Ruby', repos: %w(opscode/rails-quick-start), description: ''},
  {name: 'Deployment: Webservers', lang: 'Ruby', repos: %w(macournoyer/thin rack/rack defunkt/unicorn puma/puma celluloid/reel postrank-labs/goliath zedshaw/mongrel2 ged/ruby-mongrel2 FooBarWidget/passenger), description: "Give Unicorn a try. There are also Rainbows! / Zbatery and others, each for specific kinds of apps."},
  {name: 'Deployment: Backups', lang: 'Ruby', repos: %w(meskyanichi/backup), description: ""},
  # Development
  {name: 'Development: Editors', lang: 'Ruby/JS/Design', repos: %w(redcar/redcar adobe/brackets textmate/textmate), description: ""},
  {name: 'Development: Development Webserver', lang: 'Ruby', repos: %w(37signals/pow rodreegez/powder), description: 'Automatically run your apps on your local machine, and access them with special domains in your browser.'},
  {name: 'Development: Development Machine Setup', lang: 'Ruby', repos: %w(atmos/smeagol thoughtbot/laptop oscardelben/RailsOneClick tokaido/tokaidoapp), description: 'Set up your laptop for Ruby or Rails development. http://www.rubypluspl.us/2012/06/ubuntu-1204-ruby-on-rails-development.html - Setting up ubuntu for RoR development.'},
  {name: 'Development: Manage Ruby Versions', lang: 'Ruby', repos: %w(wayneeseguin/rvm sstephenson/rbenv remear/jewelrybox ), description: 'Install the latest ruby builds on your laptop. You can also use different ruby versions on different projects.'},
  {name: 'Development: Routing', lang: 'Ruby', repos: %w(bjeanes/ghost 37signals/pow), description: ""},
  {name: 'Development: Webservers', lang: 'Ruby', repos: %w(37signals/pow pyromaniac/hoof rtomayko/shotgun puma/puma-express jc00ke/guard-puma), description: ""},
  # Documentation
  {name: 'Documentation: Templates', lang: 'Ruby', repos: %w(mislav/hanna), description: ""},
  {name: 'Documentation: Generators', lang: 'Ruby', repos: %w(lsegal/yard), description: ""},

  # E
  # E-Commerce
  {name: 'E-Commerce: Onlineshops', lang: 'Ruby', repos: %w(spree/spree drhenner/ror_ecommerce Shopify/shopify_app Shopify/shopify_api), description: "Online store related gems."},
  {name: 'E-Commerce: Fulfillment & Shipping', lang: 'Ruby', repos: %w(Shopify/active_shipping spree/spree_active_shipping Shopify/active_fulfillment), description: "Online store related gems."},
  {name: 'E-Commerce: Payments & API Clients for Payment Processing Services', lang: 'Ruby', repos: %w(Shopify/active_merchant chargify/chargify_api_ares tylerhunt/remit rlivsey/rspreedly spreedly/spreedly-gem expectedbehavior/cheddargetter_client_ruby recurly/recurly-client-ruby fnando/paypal-recurring pengwynn/chargify nov/paypal-express braintree/braintree_ruby tc/paypal_adaptive stripe/stripe-ruby), description: "Get paid for your work. Includes Services that offer recurring subscription billing as well as one-time payments. Can handle credit card payments as well as paypal and other forms."},
  # Email
  {name: 'Email: Backup', lang: 'Ruby', repos: %w(rgrove/larch), description: ""},
  {name: 'Email', lang: 'Ruby', repos: %w(mikel/mail), description: ""},

  # F
  {name: 'Feeds: Fetch & Parse', lang: 'Ruby', repos: %w(pauldix/feedzirra pauldix/sax-machine), description: ""},


  # Frameworks
  {name: 'Frameworks: Scripting & Command Line Applications', lang: 'Ruby', repos: %w(wycats/thor jimweirich/rake blambeau/quickl mdub/clamp), description: "Build tools."},
  # Forms
  {name: 'Forms: Client-Side Validation', lang: 'Ruby', repos: %w(bcardarella/client_side_validations amatsuda/html5_validators dockyard/client_side_validations-simple_form), description: "Automatically validate forms on the client side using Javascript or the latest HTML5 Validation Standards. Rules can be automatically extracted from the validations set in your model."},
  {name: 'Forms: Multi-Step Forms / Wizard Forms', lang: 'Ruby', repos: %w(schneems/wicked intridea/rails_wizard antonversal/stepper jeffp/wizardly RailsApps/rails_apps_composer), description: "Also consider the corresponding JS Plugins."},
  {name: 'Forms: Datepickers', lang: 'Ruby', repos: %w(kristianmandrup/ui_datepicker-rails3 albertopq/jquery_datepicker trentrichardson/jQuery-Timepicker-Addon), description: ""},
  {name: 'Forms: Email & Contact Forms', lang: 'Ruby', repos: %w(plataformatec/mail_form jdutil/contact_us eric1234/rack_mailer), description: "Also consider the ActiveAttr gem and the matching Railscasts episode."},
  {name: 'Forms: Spam Minimization', lang: 'Ruby', repos: %w(achiu/rack-recaptcha curtis/honeypot-captcha moowahaha/despamilator sinisterchipmunk/bot-away joshfrench/rakismet henrikhodne/defender matthutchinson/acts_as_textcaptcha gutomcosta/simple-spam-filter), description: "Act on this problem only when it is a problem. Premature optimization is your enemy. Spam protection is often done using a single form field hidden by CSS rules that has to remain blank. If a value has been filled in and is sent along you know only a spam bot could have filled that form. Also take a look at the Javascript: Captchas and Spam Minimization section."},
  {name: 'Forms: Nested Forms', lang: 'Ruby', repos: %w(nathanvda/cocoon lailsonbm/awesome_nested_fields the-teacher/the_sortable_tree), description: ''},
  {name: 'Forms: Multi-Step Forms / Wizard Forms', lang: 'JS', repos: %w(wbotelhos/stepy kflorence/jquery-wizard thecodemine/formwizard dominicbarnes/jWizard mstratman/jQuery-Smart-Wizard), description: ""},

  # G
  {name: 'Git: Guides / Styleguides / Learning Git', lang: 'Ruby/JS', repos: %w(rogerdudler/git-guide blynn/gitmagic nvie/gitflow), description: ''},
  {name: 'Git: Accessing Git from Ruby', lang: 'Ruby', repos: %w(mojombo/grit judofyr/gash schacon/ruby-git), description: ""},
  {name: 'Git: Self-Hosted Git Servers', lang: 'Ruby/JS', repos: %w(gitlabhq/gitlabhq toolmantim/bananajour), description: ""},
  {name: 'Git: Apps / GUIs', lang: 'Ruby/JS', repos: %w(Caged/gitnub), description: ""},
  {name: 'Git: Commit Messages', lang: 'Ruby/JS', repos: %w(mroth/lolcommits), description: ""},
  {name: 'Git: Flow Model & Scripts', lang: 'Ruby/JS', repos: %w(jwiegley/git-scripts nvie/gitflow), description: ""},

  # H
  {name: 'Hash Extensions', lang: 'Ruby', repos: %w(intridea/hashie svenfuchs/hashr ahoward/map delano/gibbler ismasan/hash_mapper rubyworks/hashery), description: ""},
  {name: 'HTTP: Consoles', lang: 'Ruby', repos: %w(htty/htty), description: ""},
  {name: 'HTTP: Clients', lang: 'Ruby', repos: %w(typhoeus/typhoeus deepfryed/http-parser-lite c42/wrest Manfred/SHL), description: "Consume APIs and web services."},


  # I
  {name: 'Mobile: Backend', lang: 'JS', repos: %w(adelevie/parse-ruby-client), description: ""},
  {name: 'Mobile: Text Editor Helpers', lang: 'JS', repos: %w(rubymotion/BubbleWrap rubymotion/teacup diemer/RubyMotionSublimeCompletions), description: ""},
  {name: 'ActiveModel: Validations', lang: 'Ruby', repos: %w(Fingertips/validation-sets alexdunae/validates_email_format_of Fingertips/validates_email-san hallelujah/valid_email perfectline/validates_email pluginaweek/validates_as_email_address spectator/validates_email balexand/email_validator mpalmer/email-address-validator codyrobbins/active-model-email-validator), description: ""},
  {name: 'Development: File System Watchers', lang: 'Ruby', repos: %w(guard/guard alloy/kicker), description: "Watch the file system and trigger actions (i.e. automatic compilation or browser reload) on file changes."},
  {name: 'Development: Notifications', lang: 'Ruby', repos: %w(fnando/notifier), description: ""},
  {name: 'Git: Analysis', lang: 'Ruby', repos: %w(koraktor/metior), description: "Git and Github Analysis."},
  {name: 'API: Examples', lang: 'Ruby', repos: %w(500px/api-documentation), description: ""},
  {name: 'Mobile: RubyMotion', lang: 'Ruby', repos: %w(clayallsopp/formotion), description: ""},
  {name: 'Sinatra: Bootstrapped Projects', lang: 'Ruby', repos: %w(dbrock/blossom JangoSteve/heroku-sinatra-app), description: "Quickstart your Sinatra Project."},
  {name: 'Emails: Spam Protection', lang: 'Ruby', repos: %w(sumbach/postfixer), description: ""},
  {name: 'Data Fabibricators & Fake Data', lang: 'Ruby', repos: %w(stympy/faker goncalossilva/dummy goncalossilva/dummy_data), description: ""},
  {name: 'ActiveRecord: Direct Value Access', lang: 'Ruby', repos: %w(ernie/valium), description: "Access Values directly without instanciating ActiveRecord objects."},
  {name: 'Single Page Browser Apps', lang: 'JS/Ruby', repos: %w(Shopify/batman), description: ""},
  {name: 'Geolocation', lang: 'Ruby', repos: %w(collectiveidea/graticule anthonator/skittles), description: ""},
  {name: 'Page Guides & Feature Tours', lang: 'JS', repos: %w(tracelytics/pageguide jeff-optimizely/Guiders-JS zurb/joyride), description: "How should user use your website? Point them around or create interactive feature tours."},
  {name: 'Markdown: Parsers', lang: 'JS', repos: %w(chjj/marked evilstreak/markdown-js benmills/robotskirt), description: ""},
  {name: 'Markdown: On-Page Editors', lang: 'JS', repos: %w(OscarGodson/EpicEditor joemccann/dillinger fivesixty/notepages jgauffin/griffin.editor), description: ""},
  {name: 'Markdown: Preview', lang: 'JS', repos: %w(zachwill/markdrop), description: ""},
  {name: 'On-Page Rich-Text Editors', lang: 'JS', repos: %w(xing/wysihtml5), description: "On-page WYSIWYG Editors."},
  {name: 'Slideshows', lang: 'JS', repos: %w(gnab/remark), description: ""},
  {name: 'Text Editors: Plugins & Bundles', lang: 'Ruby/JS/Design', repos: %w(textmate/markdown.tmbundle ttscoff/MarkdownEditing), description: "Bundles mainly enhancing TextMate and SublimeText2."},
  {name: 'Rating & Voting', lang: 'JS', repos: %w(ripter/jquery.rating wbotelhos/raty), description: ""},
  {name: 'Optimize: API Caching & Throttling', lang: 'Ruby', repos: %w(vigetlabs/cachebar mloughran/api_cache dambalah/api-throttling), description: ""},
  {name: 'Web Scraping', lang: 'Ruby', repos: %w(sathish316/scrapify), description: ""},
  {name: 'ActiveRecord: Comments', lang: 'Ruby', repos: %w(elight/acts_as_commentable_with_threading phusion/juvia Draiken/opinio), description: ""},
  {name: 'Mobile: Push Messages', lang: 'Ruby', repos: %w(groupon/urbanairship), description: ""},
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
  {name: 'Metrics: Event Logging & Aggregation / Exception Tracking & Stats Servers', lang: 'Ruby', repos: %w(paulasmuth/fnordmetric dcramer/sentry noahhl/batsd Fudge/gltail), description: ""},
  {name: 'Mobile: Android Development', lang: 'Ruby', repos: %w(ruboto/ruboto), description: ""},
  {name: 'Mongoid: Plugins', lang: 'Ruby', repos: %w(aq1018/mongoid-history hakanensari/mongoid-slug lucasas/will_paginate_mongoid proton/mongoid_rateable), description: ''},
  {name: 'Mongoid: Search', lang: 'Ruby', repos: %w(aaw/mongoid_fulltext mauriciozaffari/mongoid_search), description: ""},
  {name: 'Music: Office Radio', lang: 'Ruby', repos: %w(play/play), description: "Music makes the heart shine."},

  # N
  {name: 'Node: Guides / Styleguides', lang: 'JS', repos: %w(felixge/nodeguide.com), description: ''},

  # O
  {name: 'Oauth Servers', lang: 'Ruby', repos: %w(Lelylan/rest-oauth2-server nov/rack-oauth2 assaf/rack-oauth2-server rubycas/rubycas-server dennisreimann/masq), description: ""},
  # Optimize
  {name: 'Optimize: Split Testing / A/B Testing', lang: 'Ruby', repos: %w(xing/absurdity andrew/split assaf/vanity jhubert/rails-split-tester hayesgm/mountain_goat), description: 'Optimizing your website conversion rates can include A/B-Testing, Split Testing, Multivariate Testing, and more. Test your assumptions to see what is not working and what is.'},
  {name: 'Optimize: Split Testing / A/B Testing', lang: 'JS', repos: %w(jamesyu/cohorts grippy/node-multivariate thumbtack/abba jgallen23/dice-roll), description: 'Optimizing your website conversion rates can include A/B-Testing, Split Testing, Multivariate Testing, and more. Test your assumptions to see what is not working and what is.'},
  {name: 'Optimize: Stylesheets', lang: 'Ruby', repos: %w(aanand/deadweight), description: ""},
  {name: 'Optimize: Code Quality Metrics', lang: 'Ruby', repos: %w(railsbp/rails_best_practices), description: ""},
  {name: 'Optimize: Database Queries & Structure', lang: 'Ruby', repos: %w(flyerhzm/bullet nesquena/query_reviewer eladmeidar/rails_indexes), description: ""},
  {name: 'Optimize: Log Analysis & Aggregation', lang: 'Ruby', repos: %w(wvanbergen/request-log-analyzer), description: ""},
  {name: 'Optimize: Caching', lang: 'Ruby', repos: %w(Arjeno/catche), description: "http://tomayko.com/writings/things-caches-do - HTTP Caching - Basic Article"},
  {name: 'Optimize: Code Conciseness', lang: 'Ruby', repos: %w(voxdolo/decent_exposure plataformatec/responders), description: ""},
  {name: 'Optimize: Performance Monitoring', lang: 'Ruby', repos: %w(newrelic/rpm), description: "http://railslab.newrelic.com/scaling-rails - Optimizing: Scaling Rails"},
  {name: 'Optimize: SEO', lang: 'Ruby', repos: %w(kpumuk/meta-tags), description: ""},
  # ORMs
  {name: 'ORMs: Key-Value Stores', lang: 'Ruby', repos: %w(technoweenie/horcrux jnunemaker/toystore soveran/ohm), description: ""},
  {name: 'ORMs: MongoDB', lang: 'Ruby', repos: %w(mongoid/mongoid jnunemaker/mongomapper), description: ""},
  {name: 'ORMs: MySQL', lang: 'Ruby', repos: %w(jeremyevans/sequel datamapper/dm-core), description: "ActiveRecord"},
  {name: 'ORMs: NoSQL', lang: 'Ruby', repos: %w(twitter/cassandra seancribbs/ripple Imikimi-LLC/monotable), description: ""},



  # P
  # Parsers
  {name: 'Parsers: CSV', lang: 'Ruby', repos: %w(seamusabshere/data_miner pillowfactory/csv-mapper internuity/map-fields seamusabshere/remote_table), description: ''},
  {name: 'Parsers: HTML & Sanitizers', lang: 'Ruby', repos: %w(sparklemotion/nokogiri flavorjones/loofah), description: ''},
  {name: 'Parsers: JSON', lang: 'Ruby', repos: %w(ohler55/oj intridea/multi_json flori/json brianmario/yajl-ruby jnunemaker/crack kr/okjson dgraham/json-stream), description: ''},
  {name: 'Parsers: Markdown', lang: 'Ruby', repos: %w(tanoku/redcarpet tanoku/sundown rtomayko/rdiscount github/github-flavored-markdown vigetlabs/acts_as_markup gettalong/kramdown postmodern/multi_markdown jgarber/redcloth), description: ""},
  {name: 'Parsers: PDF', lang: 'Ruby', repos: %w(yob/pdf-reader jonmagic/grim CrossRef/pdfextract tcocca/active_pdftk), description: ""},
  {name: 'Parsers: URL & URI', lang: 'Ruby', repos: %w(sporkmonger/addressable pauldix/domainatrix), description: ""},
  {name: 'Parsers: XLS', lang: 'Ruby', repos: %w(seamusabshere/data_miner seamusabshere/remote_table), description: ''},
  {name: 'Parsers: XML', lang: 'Ruby', repos: %w(jnunemaker/crack rubiii/nori sparklemotion/nokogiri flavorjones/loofah jnunemaker/happymapper seamusabshere/data_miner), description: ''},
  {name: 'Parsers: Natural Language Dates', lang: 'Ruby', repos: %w(mojombo/chronic hpoydar/chronic_duration), description: ""},
  # PDF
  {name: 'PDF: PDF & Ebook Writers', lang: 'Ruby', repos: %w(blueheadpublishing/bookshop prawnpdf/prawn igor-alexandrov/wisepdf pdfkit/pdfkit antialize/wkhtmltopdf mileszs/wicked_pdf fnando/kitabu shairontoledo/rghost walle/gimli TechnoGate/transmuter plessl/wkpdf  tcocca/active_pdftk expectedbehavior/doc_raptor_gem mbleigh/princely fnando/kitabu), description: ""},
  {name: 'PDF: Parsers', lang: 'Ruby', repos: %w(yob/pdf-reader jonmagic/grim CrossRef/pdfextract tcocca/active_pdftk), description: ""},
  {name: 'Presentations', lang: 'Ruby/JS', repos: %w(bmcmurray/hekyll), description: ""},
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
  {name: 'Views: CSS Preprocessors', lang: 'Design', repos: %w(nex3/sass chriseppstein/compass cowboyd/less.rb cloudhead/less.js), description: "Still writing plain CSS? Consider using SASS, Less, Stylus or any other preprocessor. They generally give you advanced features like variables, mixins, color functions and more. For some of them there are great mixin libraries available."},
  {name: 'Design Frameworks', lang: 'Design', repos: %w(twitter/bootstrap zurb/foundation h5bp/html5-boilerplate necolas/normalize.css joshuaclayton/blueprint-css), description: "Build great looking websites with ease."},
  {name: 'SASS Mixin Libraries', lang: 'Design', repos: %w(thoughtbot/bourbon), description: ""},
  {name: 'Images: Sprite Generators', lang: 'Ruby', repos: %w(jakesgordon/sprite-factory), description: ""},
  {name: 'Speach: Making Ruby Speak', lang: 'Ruby', repos: %w(ruby-talks/talks), description: ""},
  {name: 'Speach: Siri Proxies', lang: 'Ruby', repos: %w(plamoni/SiriProxy), description: ""},


  # T
  {name: 'Templating: JSON', lang: 'Ruby', repos: %w(nesquena/rabl fabrik42/acts_as_api), description: ''},
  {name: 'Templating: XML', lang: 'Ruby', repos: %w(nesquena/rabl fabrik42/acts_as_api), description: ''},
  {name: 'Testing: Build Systems & Continuous Integration', lang: 'Ruby', repos: %w(travis-ci/travis-ci defunkt/cijoe github/janky jenkinsci/jenkins.rb c42/goldberg), description: ""},

  # U
  {name: 'UUID Generators', lang: 'Ruby', repos: %w(assaf/uuid ryanking/simple_uuid jashmenn/activeuuid sporkmonger/uuidtools norbert/has_uuid), description: ""},

  # V
  {name: 'Views: Calendar Helpers', lang: 'Ruby', repos: %w(topfunky/calendar_helper), description: ""},
  {name: 'Views: Table Builders', lang: 'Ruby', repos: %w(provideal/tabulatr watu/table_builder jgdavey/tabletastic tokumine/fusion_tables pluginaweek/table_helper lunich/table_for), description: "Render table with searching and sorting helpers."},
  {name: 'Views: Tabs', lang: 'Ruby', repos: %w(weppos/tabs_on_rails), description: ""},
  {name: 'Views: Templating Engines & Languages', lang: 'Ruby', repos: %w(haml/haml stonean/slim Shopify/liquid rtomayko/tilt defunkt/mustache markaby/markaby blambeau/wlang agoragames/stache jamesarosen/handlebars-rails joliss/markdown-rails), description: "Tired of <html>? Try slim and companions."},
  {name: 'Views: Navigation Helpers', lang: 'Ruby', repos: %w(andi/simple-navigation bkuhlmann/navigator), description: ""},

  # W
  {name: 'Websockets', lang: 'Ruby', repos: %w(igrigorik/em-websocket gimite/web-socket-ruby celluloid/celluloid-io stripe/einhorn), description: ""},
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
  {name: 'Tagging', lang: 'JS', repos: %w(ivaynberg/select2), description: ""},
  {name: 'Selects', lang: 'JS', repos: %w(ivaynberg/select2 harvesthq/chosen), description: ""},
  {name: 'Async Image Loaders', lang: 'JS', repos: %w(sebarmeli/JAIL), description: ""},
  {name: 'Syntax Highlighting', lang: 'JS', repos: %w(ccampbell/rainbow), description: ""},
  {name: 'Mobile: Phonegap', lang: 'JS', repos: %w(phonegap/phonegap Toura/mulberry apache/incubator-cordova-android apache/incubator-cordova-ios apache/incubator-cordova-mac), description: ""},
  {name: 'Styleguides: Misc', lang: 'JS/Ruby', repos: %w(oreilly/couchdb-guide), description: ''},
  {name: 'jQuery on Server', lang: 'JS', repos: %w(MatthewMueller/cheerio), description: ""},
  {name: 'API Builders & Servers', lang: 'JS', repos: %w(kilianc/node-apiserver), description: ""},
  {name: 'CI', lang: 'JS', repos: %w(ryankee/concrete), description: ""},


  # Design
  {name: 'Buttons', lang: 'Design', repos: %w(michenriksen/css3buttons thetron/css3buttons_rails_helpers necolas/css3-github-buttons ubuwaits/css3-buttons), description: ""},
  {name: 'Launch & Landing Pages', lang: 'Design', repos: %w(carmivore/comingsoon webandy/notify-me), description: "Landing Pages & Email Signup pages."},
  {name: 'Styleguides', lang: 'Design', repos: %w(necolas/idiomatic-css csswizardry/CSS-Guidelines), description: 'Write consistent and maintainable view files. Book recommendation: The Rails View, Pragmatic Programmers.'},
  {name: 'Documentation', lang: 'Design', repos: %w(kneath/kss), description: ""},
  {name: 'Placeholders', lang: 'Design/JS', repos: %w(imsky/holder), description: ""},
  {name: 'Typography: Showcases', lang: 'Design', repos: %w(ubuwaits/beautiful-web-type), description: ""},
  {name: 'Optimize: Merge & Minify', lang: 'Design', repos: %w(cjohansen/juicer), description: ""},
  {name: 'Pagination', lang: 'Design', repos: %w(brajeshwar/paginate), description: ""},
  {name: 'Mobile: UI', lang: 'Design', repos: %w(triceam/app-UI), description: ""},
  {name: 'Grids', lang: 'Design', repos: %w(ericam/susy), description: ""},



  {name: 'Rails: Project Generators & Templates', lang: 'Ruby', repos: %w(bkuhlmann/rails_setup_template), description: 'Get your project off the ground with ease.'},
  {name: 'Icon Fonts', lang: 'Design', repos: %w(FortAwesome/Font-Awesome pfefferle/openwebicons zurb/foundation-icons), description: 'Icon fonts are the new way to get icons on a website. Advantages over image files: Scalable to every size because they are vectorised; Most CSS3 Properties are available: Shadows, Borders etc. Color can be changed freely.'},
  {name: 'Ruby: Guides / Styleguides', lang: 'Ruby', repos: %w(bbatsov/rails-style-guide bbatsov/ruby-style-guide copycopter/style-guide davetron5000/ruby-style), description: 'Write maintainable ruby code.'},
  {name: 'Twitter API Clients', lang: 'Ruby', repos: %w(intridea/tweetstream jnunemaker/twitter sferik/t jugyo/earthquake marcel/twurl twitter/twitter-text-rb voloko/twitter-stream seejohnrun/console_tweet), description: 'API Wrappers for Twitter.'},
  {name: 'Collaboration: Source Code Management', lang: 'Ruby/JS', repos: %w(gitlabhq/gitlabhq), description: 'Version Control for your code.'},
  {name: 'Collaboration / Project Management',lang: 'Ruby/JS', repos: %w(teambox/teambox), description: 'Team collaboration.'},
  {name: 'Rails App Tutorials', lang: 'Ruby', repos: %w(RailsApps/rails3-bootstrap-devise-cancan sferik/sign-in-with-twitter RailsApps/rails-prelaunch-signup RailsApps/rails3-mongoid-omniauth RailsApps/rails3-mongoid-devise RailsApps/rails3-bootstrap-devise-cancan RailsApps/rails3-devise-rspec-cucumber RailsApps/rails3-subdomains), description: 'Example apps and tutorials.'},
  {name: 'Textmate and Sublime Text Snippets', lang: 'Ruby/JS/Design', repos: %w(devtellect/sublime-twitter-bootstrap-snippets), description: 'Code Editor snippets. Mostly Textmate and Sublime Text. You can generally use Textmate Plugins in Sublime Text 2.'},
  {name: 'Twitter Bootstrap for Rails', lang: 'Ruby', repos: %w(mjbellantoni/formtastic-bootstrap rafaelfranca/simple_form-bootstrap sethvargo/bootstrap_forms  metaskills/less-rails-bootstrap anjlab/bootstrap-rails yabawock/bootstrap-sass-rails xdite/bootstrap-helper yrgoldteeth/bootstrap-will_paginate decioferreira/bootstrap-generators pusewicz/twitter-bootstrap-markup-rails thomaspark/bootswatch anjlab/bootstrap-rails markdotto/bootstrap-university), description: 'Helpers for using Twitter Bootstrap with Rails.'},
  {name: 'Web Design Elements', lang: 'Design', repos: %w(todc/css3-google-buttons necolas/normalize.css necolas/css3-github-buttons michenriksen/css3buttons), description: 'Buttons, Form Styles, Cross-Browser Styles etc.'},
=end
]

# Plugins
# {parent: '', children: %w()},

plugins = [
  {parent: 'thoughtbot/paperclip', children: %w(websymphony/Rails3-Paperclip-Uploadify jstorimer/delayed_paperclip igor-alexandrov/paperclip-aws dripster82/paperclipdropbox nhocki/paperclip-s3 kellym/mongoid_paperclip_queue bkuhlmann/paperclip_plus)},
  {parent: 'padrino/padrino-framework', children: %w(padrino/padrino-recipes)},
  {parent: 'jnicklas/carrierwave', children: %w(dwilkie/carrierwave_direct)},
  {parent: 'twitter/bootstrap', children: %w(seyhunak/twitter-bootstrap-rails thomas-mcdonald/bootstrap-sass)},
  {parent: 'kneath/kss', children: %w(dewski/kss-rails)},
  {parent: 'pry/pry', children: %w(rweng/pry-rails nixme/pry-nav Mon-Ouie/pry-remote nixme/pry-debugger)},
  {parent: 'prawnpdf/prawn', children: %w(forrest/prawnto bkuhlmann/prawn_plus sbfaulkner/sinatra-prawn rtsinani/gambas)},
  {parent: 'mileszs/wicked_pdf', children: %w(michaelklem/heroku-pdf-3)},
  {parent: 'mislav/will_paginate', children: %w(nickpad/will_paginate-bootstrap yrgoldteeth/bootstrap-will_paginate travisjeffery/will_paginate_twitter_bootstrap)},
  {parent: 'amatsuda/kaminari', children: %w(Djo/reverse_kaminari)},
  {parent: 'phonegap/phonegap', children: %w(davebalmer/jo phonegap/phonegap-plugins davejohnson/phonegap-plugin-facebook-connect phonegap/phonegap-start wikimedia/WikipediaMobile Toura/mulberry triceam/app-UI)},
  {parent: 'FooBarWidget/passenger', children: %w(Fingertips/passengerpane)},
  {parent: 'Shopify/batman', children: %w(Shopify/batman-rails)},
  {parent: 'intridea/hashie', children: %w(doublewide/hashie-model)},
  {parent: '', children: %w()},
  {parent: '', children: %w()},
  {parent: '', children: %w()},
  {parent: '', children: %w()},
  {parent: '', children: %w()},
  {parent: '', children: %w()},
  {parent: '', children: %w()},
  {parent: '', children: %w()},
  {parent: '', children: %w()},
  {parent: '', children: %w()}
]

if Rails.env.development?
  ads = [
    {name: 'Heroku', category_list: 'index', url: 'http://www.heroku.com', description: 'Heroku is the leading open language cloud application platform and supports Ruby, Java, Python, Clojure, Scala, Node.js. and custom language buildpacks.'}
  ]
end


Rails.logger.info "Processing Seed Categories and Repos..."

# Enter or update seeds
seeds.each do |seed|

  # Build category name
  category_name = "#{ seed[:name] } (#{ seed[:lang] })"

  ###
  #   Create or update categories
  ###
  # Find or initialize category
  category = Category.find_or_initialize_by_name(category_name)

  # Seed descriptions unless present
  category.short_description = seed[:description] unless category.short_description.present?
  category.description = seed[:description] unless category.description.present?

  # Save Category
  category.save

  ###
  #   Create or update repos
  ###
  seed[:repos].each do |full_name|
    # Find or initialize repo
    repo = Repo.find_or_initialize_by_full_name(full_name)

    # Assign multiple categories to a repo while seeding
    categories = []
    categories << repo.category_list
    categories << category_name
    repo.category_list = categories.join(', ')

    # Save repo
    repo.save
  end
end

Rails.logger.info 'Processing Plugins...'

# Write Plugins
plugins.each do |plugin|
  # Children
  #  ( Makes sure children are known if they aren't listed in any category
  #    and thus not seeded yet )
  plugin[:children].each { |full_name| Repo.find_or_create_by_full_name(full_name) }

  # Write 'Association'
  parent = Repo.find_or_initialize_by_full_name(plugin[:parent])
  parent.child_list = plugin[:children].join(', ')
  parent.save
end

# Update Knight in serial
KnightUpdater.update_knight_serial

# Log success
Rails.logger.info 'Finished writing seeds successfully.'