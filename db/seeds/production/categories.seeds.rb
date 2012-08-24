# encoding: UTF-8
# production/categories.seeds.rb

###
### Do not add new repos to existing categories here
### Add them to Knight.io on the website
###

categories_and_repos = [
  # Batch 1
=begin
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

  # Batch 2
  {name: 'ActiveRecord: Soft Deleting', lang: 'Ruby', repos: %w(radar/paranoia goncalossilva/rails3_acts_as_paranoid JackDanger/permanent_records teambox/immortal expectedbehavior/acts_as_archival nay/never_wastes socialcast/delete_paranoid), description: 'Destroyed objects will remain in the database, in a hidden way.'},
  {name: 'ActiveRecord: Versioning, Auditing & History Tracking', lang: 'Ruby', repos: %w(collectiveidea/audited harleyttd/auditable airblade/paper_trail technoweenie/acts_as_versioned jmckible/version_fu bdurand/acts_as_revisionable Tapjoy/acts_as_approvable Sigiz/record_history seejohnrun/track_history nearinfinity/auditor laserlemon/vestal_versions), description: "Track changes to your model's data. Related: [ActiveModel Dirty Objects](http://api.rubyonrails.org/classes/ActiveModel/Dirty.html) helps keeping track of the changes to an object before it is being saved."},
  {name: 'ActiveRecord: Data Migrations', lang: 'Ruby', repos: %w(soundcloud/large-hadron-migrator portablemind/data_migrator), description: ""},
  {name: 'ActiveRecord: Enumerations & State-Machines', lang: 'Ruby', repos: %w(svenfuchs/simple_states pluginaweek/state_machine twinslash/enumerize yonbergman/enumify beerlington/classy_enum electronick/enum_column cassiomarques/enumerate_it lwe/simple_enum novelys/static_list), description: ''},
  {name: 'ActiveRecord: Pagination & Sorting', lang: 'Ruby', repos: %w(mislav/will_paginate amatsuda/kaminari mynameisrufus/sorted ronalchn/ajax_pagination provideal/tabulatr hiteshrawal/sortable godfat/pagify Fingertips/peiji-san leikind/wice_grid bkuhlmann/sorter), description: ""},
  {name: 'ActiveRecord: Friendly Ids', lang: 'Ruby', repos: %w(norman/friendly_id bkuhlmann/tokener bumi/find_by_param), description: "Human Readable Ids. User-Friendly and SEO-Optimized."},
  {name: 'ActiveRecord: Seeds', lang: 'Ruby', repos: %w(mbleigh/seed-fu rhalff/seed_dump sevenwire/bootstrapper james2m/seedbank simonc/versioned_seeds developer357/seeds midas/genesis innku/seedsv markmcspadden/seed_me kevTheDev/seed_dumper), description: "Seed data. http://railscasts.com/episodes/179-seed-data http://www.ruby-auf-schienen.de/buch/seed_rb.html (in German)"},
  {name: 'Apps: Wikis', lang: 'Ruby', repos: %w(github/gollum sr/git-wiki dreverri/gollum-site), description: ""},
  {name: 'Apps: Project Management & Organization', lang: 'Ruby', repos: %w(redmine/redmine chiliproject/chiliproject gitlabhq/gitlabhq malclocke/fulcrum ari/jobsworth jamesu/railscollab Bettermeans/bettermeans camelpunch/simply_agile kiskolabs/splendidbacon), description: ""},
  {name: 'Deployment: Webservers', lang: 'Ruby', repos: %w(macournoyer/thin rack/rack defunkt/unicorn puma/puma celluloid/reel postrank-labs/goliath zedshaw/mongrel2 ged/ruby-mongrel2 FooBarWidget/passenger), description: ""},
  {name: 'Development: Webservers', lang: 'Ruby', repos: %w(37signals/pow rodreegez/powder pyromaniac/hoof rtomayko/shotgun puma/puma-express jc00ke/guard-puma), description: "Run and restart local apps automatically while developing."},

  # Batch 3
  {name: 'ActiveRecord: Model Annotations', lang: 'Ruby', repos: %w(ctran/annotate_models), description: "Annotate your models with your database schema."},
  {name: 'ActiveRecord: Tags, Favorites & Votes', lang: 'Ruby', repos: %w(mbleigh/acts-as-taggable-on bradphelan/rocket_tag chrome/markable schneems/likeable leehambley/opinions peteonrails/vote_fu medihack/make_voteable twitter/activerecord-reputation-system vshvedov/vote_fu_rails_3 raw1z/amistad edgarjs/ajaxful-rating glynx/rateable ygor/acts_as_rateable sujitsagar/acts_as_rateable asceth/acts_as_rateable anton-zaytsev/acts_as_rateable), description: 'Tagging and marking for your ActiveRecord models.'},
  {name: 'ActiveRecord: Nesting', lang: 'Ruby', repos: %w(collectiveidea/awesome_nested_set mceachen/closure_tree amerine/acts_as_tree ryanb/nested_form stefankroes/ancestry elight/acts_as_commentable_with_threading the-teacher/the_sortable_tree clyfe/acts_as_nested_interval amatsuda/nested_scaffold thinkwell/mongoid_nested_set svenfuchs/simple_nested_set bkuhlmann/lineage), description: "The nested set model is a particular technique for representing nested sets (also known as trees or hierarchies) in relational databases."},
  {name: 'ActiveRecord: Lists & Sortable Columns', lang: 'Ruby', repos: %w(swanandp/acts_as_list the-teacher/the_sortable_tree dadooda/handles_sortable_columns 12spokes/acts_as_restful_list codegram/resort mixonic/ranked-model shuber/sortable bogdan/datagrid thoughtbot/sortable_table), description: 'Related: [ActiveRecord: Nesting](#)'},
  {name: 'Console: IRB Replacements', lang: 'Ruby', repos: %w(pry/pry cldwalker/hirb codegram/rack-webconsole blackwinter/brice ileitch/hijack), description: ""},
  {name: 'Console: Alternative Command Line Shells', lang: 'Ruby/JS', repos: %w(fish-shell/fish-shell), description: ""},
  {name: 'Console: Frameworks for Console-Based Apps', lang: 'Ruby', repos: %w(koraktor/rubikon), description: ""},
  {name: 'Console: Managing Dotfiles', lang: 'Ruby', repos: %w(mattdbridges/dotify), description: ""},
  {name: 'Database: Structure & Data Migrations', lang: 'Ruby', repos: %w(thuss/standalone-migrations), description: "Use the power of Rails Migrations for Non-Rails (and even Non-Ruby) Projects."},
  {name: 'Database: Cleaning', lang: 'Ruby', repos: %w(bmabey/database_cleaner), description: ""},
  {name: 'Database: Management Tools', lang: 'Ruby', repos: %w(tumblr/jetpants), description: ""},
  {name: 'Database: Backups', lang: 'Ruby', repos: %w(meskyanichi/backup yob/db2fog), description: ""},
  {name: 'Development: Ruby Version Management', lang: 'Ruby', repos: %w(wayneeseguin/rvm sstephenson/rbenv remear/jewelrybox ), description: ''},
  {name: 'Frameworks: Scripting & Command Line Applications', lang: 'Ruby', repos: %w(wycats/thor jimweirich/rake blambeau/quickl mdub/clamp koraktor/rubikon), description: "Build tools."},
  {name: 'Forms: Client-Side Validation', lang: 'Ruby', repos: %w(bcardarella/client_side_validations amatsuda/html5_validators dockyard/client_side_validations-simple_form), description: "Automatically validate forms on the client side using Javascript or the latest HTML5 Validation Standards. Rules can be automatically extracted from the validations set in your model."},
  {name: 'Forms: Multi-Step & Wizard Forms', lang: 'Ruby', repos: %w(schneems/wicked intridea/rails_wizard antonversal/stepper jeffp/wizardly RailsApps/rails_apps_composer), description: "Also consider the corresponding JS Plugins."},
  {name: 'Forms: Datepickers', lang: 'Ruby', repos: %w(kristianmandrup/ui_datepicker-rails3 albertopq/jquery_datepicker trentrichardson/jQuery-Timepicker-Addon), description: ""},
  {name: 'Forms: Email & Contact Forms', lang: 'Ruby', repos: %w(plataformatec/mail_form jdutil/contact_us eric1234/rack_mailer), description: "Also consider the ActiveAttr gem and the matching Railscasts episode."},
  {name: 'Forms: Spam Minimization', lang: 'Ruby', repos: %w(achiu/rack-recaptcha curtis/honeypot-captcha moowahaha/despamilator sinisterchipmunk/bot-away joshfrench/rakismet henrikhodne/defender matthutchinson/acts_as_textcaptcha gutomcosta/simple-spam-filter), description: "Act on this problem only when it is a problem. Premature optimization is your enemy. Spam protection is often done using a single form field hidden by CSS rules that has to remain blank. If a value has been filled in and is sent along you know only a spam bot could have filled that form. Also take a look at the Javascript: Captchas and Spam Minimization section."},
  {name: 'Forms: Nested Forms', lang: 'Ruby', repos: %w(nathanvda/cocoon lailsonbm/awesome_nested_fields the-teacher/the_sortable_tree), description: ''},
  {name: 'Forms: Multi-Step & Wizard Forms', lang: 'JS', repos: %w(wbotelhos/stepy kflorence/jquery-wizard thecodemine/formwizard dominicbarnes/jWizard mstratman/jQuery-Smart-Wizard), description: ""},
  {name: 'HTTP: Consoles', lang: 'Ruby', repos: %w(htty/htty), description: ""},
  {name: 'HTTP: Clients', lang: 'Ruby', repos: %w(typhoeus/typhoeus deepfryed/http-parser-lite c42/wrest Manfred/SHL), description: "Consume APIs and web services."},
=end

  # Batch 4
  {name: 'PDF: PDF & Ebook Writers', lang: 'Ruby', repos: %w(blueheadpublishing/bookshop prawnpdf/prawn igor-alexandrov/wisepdf pdfkit/pdfkit antialize/wkhtmltopdf mileszs/wicked_pdf fnando/kitabu shairontoledo/rghost walle/gimli TechnoGate/transmuter plessl/wkpdf  tcocca/active_pdftk expectedbehavior/doc_raptor_gem mbleigh/princely fnando/kitabu), description: ""},
  {name: 'PDF: Parsers', lang: 'Ruby', repos: %w(yob/pdf-reader jonmagic/grim CrossRef/pdfextract tcocca/active_pdftk), description: ""},
  {name: 'Testing: Build Systems & Continuous Integration', lang: 'Ruby', repos: %w(travis-ci/travis-ci defunkt/cijoe github/janky jenkinsci/jenkins.rb c42/goldberg), description: ""},
  {name: 'WYSIWYG Editors', lang: 'Ruby', repos: %w(jejacks0n/mercury kete/tiny_mce bastiaanterhorst/rich), description: ""},
  {name: 'Websockets', lang: 'Ruby', repos: %w(igrigorik/em-websocket gimite/web-socket-ruby celluloid/celluloid-io stripe/einhorn), description: ""},
  {name: 'Views: Templating Engines & Languages', lang: 'Ruby', repos: %w(haml/haml stonean/slim Shopify/liquid rtomayko/tilt defunkt/mustache markaby/markaby blambeau/wlang agoragames/stache jamesarosen/handlebars-rails joliss/markdown-rails), description: "Tired of <html>? Try slim and companions."},
  {name: 'Views: Navigation Bars', lang: 'Ruby', repos: %w(andi/simple-navigation bkuhlmann/navigator), description: ""},
  {name: 'Views: Calendars', lang: 'Ruby', repos: %w(topfunky/calendar_helper), description: ""},
  {name: 'Views: Tables', lang: 'Ruby', repos: %w(provideal/tabulatr watu/table_builder jgdavey/tabletastic tokumine/fusion_tables pluginaweek/table_helper lunich/table_for), description: "Render table with searching and sorting helpers."},
  {name: 'Views: Tabs', lang: 'Ruby', repos: %w(weppos/tabs_on_rails), description: ""},
  {name: 'UUID Generators', lang: 'Ruby', repos: %w(assaf/uuid ryanking/simple_uuid jashmenn/activeuuid sporkmonger/uuidtools norbert/has_uuid), description: ""},
  {name: 'Optimize: SEO', lang: 'Ruby', repos: %w(kpumuk/meta-tags), description: ""},
  {name: 'Learning: Rails', lang: 'Ruby', repos: %w(devalot/ror-example), description: 'Getting better in Rails development every day is considered a noble cause. http://railsapps.github.com/rails.html - Resources on Learning Rails'},
  {name: 'Learning: Ruby Basics', lang: 'Ruby', repos: %w(JoshCheek/ruby-kickstart the-teacher/Ruby-Lessons edgecase/ruby_koans), description: 'Get better in Ruby development every day is something to live by.'},
  {name: 'Learning: Ruby Advanced', lang: 'Ruby', repos: %w(raganwald/homoiconic), description: ""},
  {name: 'Oauth Servers', lang: 'Ruby', repos: %w(Lelylan/rest-oauth2-server nov/rack-oauth2 assaf/rack-oauth2-server rubycas/rubycas-server dennisreimann/masq), description: ""},
  {name: 'E-Commerce: Onlineshops', lang: 'Ruby', repos: %w(spree/spree drhenner/ror_ecommerce Shopify/shopify_app Shopify/shopify_api), description: "Online store related gems."},
  {name: 'E-Commerce: Fulfillment & Shipping', lang: 'Ruby', repos: %w(Shopify/active_shipping spree/spree_active_shipping Shopify/active_fulfillment), description: "Online store related gems."},
  {name: 'E-Commerce: Payments & API Clients for Payment Processing Services', lang: 'Ruby', repos: %w(Shopify/active_merchant chargify/chargify_api_ares tylerhunt/remit rlivsey/rspreedly spreedly/spreedly-gem expectedbehavior/cheddargetter_client_ruby recurly/recurly-client-ruby fnando/paypal-recurring pengwynn/chargify nov/paypal-express braintree/braintree_ruby tc/paypal_adaptive stripe/stripe-ruby), description: "Get paid for your work. Includes Services that offer recurring subscription billing as well as one-time payments. Can handle credit card payments as well as paypal and other forms."},
  {name: 'Feeds: Fetch & Parse Feeds', lang: 'Ruby', repos: %w(pauldix/feedzirra pauldix/sax-machine), description: ""},
  {name: 'Email', lang: 'Ruby', repos: %w(mikel/mail), description: ""},
  {name: 'Hash Extensions', lang: 'Ruby', repos: %w(intridea/hashie svenfuchs/hashr ahoward/map delano/gibbler ismasan/hash_mapper rubyworks/hashery), description: ""},

  # Batch 5
  # Batch 6
  # Batch 7
  # Batch 8
]

# Seed Knight.io
categories_and_repos.each do |seed|
  # Build category name
  category_name = "#{ seed[:name] } (#{ seed[:lang] })"

  # Find or initialize category
  category = Category.find_or_initialize_by_name(category_name)

  # Seed category and repos if new_record?
  if category.new_record?
    category.short_description = seed[:description]
    category.description = seed[:description]
    category.save
    Rails.logger.info "Added category #{ category.name }"

    # Create or update repos
    seed[:repos].each do |full_name|
      # Find or initialize repo
      repo = Repo.find_or_initialize_by_full_name(full_name)

      # Assign multiple categories to a repo while seeding
      categories = []
      categories << repo.category_list
      categories << category_name
      repo.category_list = categories.join(', ')
      repo.save
      Rails.logger.info "Added repo #{ repo.full_name }"
    end
  else
    Rails.logger.info "Existing category #{ category.name } stays unmodified"
  end
end
