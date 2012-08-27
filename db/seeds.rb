# encoding: UTF-8
=begin
seeds = [
  # A
  # ActiveRecord
  {name: 'ActiveRecord: Normalizing', lang: 'Ruby', repos: %w(holli/auto_strip_attributes rmm5t/strip_attributes mdeering/attribute_normalizer), description: "Normalize and escape user input before saving. Also take a look at Ruby's 'strip' method and Rails' built-in 'squish' method ('Returns the string, first removing all whitespace on both ends of the string, and then changing remaining consecutive whitespace groups into one space each.' - Rails API Docs. Also take a look at the Parsers: HTML Sanitization section. Value Cleanup / Attribute Stripping / Attribute Normalizing"},
  {name: 'ActiveRecord: Default Values for Attributes', lang: 'Ruby', repos: %w(), description: "There are various ways to set defaults for the objects created by a model. Next to the gems listed here they can be set in the database / database adapter using a Rails migration (as described here: [Rails Guides on Migrations](http://guides.rubyonrails.org/migrations.html). The community-driven [Rails Styleguide](https://github.com/bbatsov/rails-style-guide#migrations) recommends setting defaults in the model rather than a table."},
  {name: 'ActiveRecord: Misc', lang: 'Ruby', repos: %w(activescaffold/active_scaffold codez/dry_crud metaskills/store_configurable robertwahler/dynabix), description: ""},
  # API
  {name: 'API: API Builders', lang: 'Ruby', repos: %w(intridea/grape filtersquad/rocket_pants LTe/grape-rabl spastorino/rails-api bploetz/versionist filtersquad/api_smith mloughran/api_cache lyonrb/biceps vigetlabs/serialize_with_options fnando/rack-api fabrik42/acts_as_api atomicobject/to_api), description: "Build an API for your application."},
  {name: 'API: XML Parsers & Builders', lang: 'Ruby', repos: %w(ohler55/ox sferik/multi_xml Empact/roxml jnunemaker/happymapper pauldix/sax-machine rubiii/gyoku mdub/representative michael-harrison/xml_active craigambrose/sax_stream soulcutter/saxerator sparklemotion/nokogiri), description: "SAX Parser = Simple API for XML Parser, event oriented parsing"},
  {name: 'API: XML Templating', lang: 'Ruby', repos: %w(nesquena/rabl jlong/radius), description: ""},
  # Apps
  {name: 'Apps: Forums & Social Network Building Blocks', lang: 'Ruby', repos: %w(radar/forem courtenay/altered_beast bborn/communityengine twitter/activerecord-reputation-system raw1z/amistad), description: ""},
  {name: 'Apps: Miscellaneous', lang: 'Ruby', repos: %w(janlelis/pws jamis/bucketwise mischa78/boxroom ugol/pomodoro visionmedia/pomo rapind/grokphoto), description: "Password Manager, Personal Finance Manager etc."},
  {name: 'Asset Pipeline', lang: 'Ruby', repos: %w(evrone/quiet_assets), description: "Mute asset pipeline log messages and more."},
  # B

  # C
  {name: 'Chat Servers', lang: 'JS/Ruby', repos: %w(negativecode/vines gravityonmars/Balloons.IO), description: ""},
  {name: 'Charts & Graphs', lang: 'Ruby', repos: %w(topfunky/gruff), description: ""},
  # Coffeescript
  {name: 'Coffeescript: Guides / Styleguides', lang: 'JS', repos: %w(polarmobile/coffeescript-style-guide), description: ''},
  {name: 'Configuration: Configuration Objects', lang: 'Ruby', repos: %w(mbklein/confstruct GutenYe/optimism), description: ""},

  # D

  # Deployment
  {name: 'Deployment', lang: 'Ruby', repos: %w(opscode/rails-quick-start), description: ''},
  {name: 'Deployment: Backups', lang: 'Ruby', repos: %w(meskyanichi/backup), description: ""},
  # Development
  {name: 'Development: Editors', lang: 'Ruby/JS/Design', repos: %w(redcar/redcar adobe/brackets textmate/textmate), description: ""},
  {name: 'Development: Development Machine Setup', lang: 'Ruby', repos: %w(atmos/smeagol thoughtbot/laptop oscardelben/RailsOneClick tokaido/tokaidoapp), description: 'Set up your laptop for Ruby or Rails development. http://www.rubypluspl.us/2012/06/ubuntu-1204-ruby-on-rails-development.html - Setting up ubuntu for RoR development.'},
  {name: 'Development: Routing', lang: 'Ruby', repos: %w(bjeanes/ghost 37signals/pow), description: ""},
  # Documentation
  {name: 'Documentation: Templates', lang: 'Ruby', repos: %w(mislav/hanna), description: ""},
  {name: 'Documentation: Generators', lang: 'Ruby', repos: %w(lsegal/yard), description: ""},

  # E
  # E-Commerce
  # Email
  {name: 'Email: Backup', lang: 'Ruby', repos: %w(rgrove/larch), description: ""},

  # F


  # G
  {name: 'Git: Guides / Styleguides / Learning Git', lang: 'Ruby/JS', repos: %w(rogerdudler/git-guide blynn/gitmagic nvie/gitflow), description: ''},
  {name: 'Git: Accessing Git from Ruby', lang: 'Ruby', repos: %w(mojombo/grit judofyr/gash schacon/ruby-git), description: ""},
  {name: 'Git: Self-Hosted Git Servers', lang: 'Ruby/JS', repos: %w(gitlabhq/gitlabhq toolmantim/bananajour), description: ""},
  {name: 'Git: Apps / GUIs', lang: 'Ruby/JS', repos: %w(Caged/gitnub), description: ""},
  {name: 'Git: Commit Messages', lang: 'Ruby/JS', repos: %w(mroth/lolcommits), description: ""},
  {name: 'Git: Flow Model & Scripts', lang: 'Ruby/JS', repos: %w(jwiegley/git-scripts nvie/gitflow), description: ""},

  # H


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

  # M
  {name: 'Metrics: Event Logging & Aggregation / Exception Tracking & Stats Servers', lang: 'Ruby', repos: %w(paulasmuth/fnordmetric dcramer/sentry noahhl/batsd Fudge/gltail), description: ""},
  {name: 'Mobile: Android Development', lang: 'Ruby', repos: %w(ruboto/ruboto), description: ""},
  {name: 'Mongoid: Plugins', lang: 'Ruby', repos: %w(aq1018/mongoid-history hakanensari/mongoid-slug lucasas/will_paginate_mongoid proton/mongoid_rateable), description: ''},
  {name: 'Mongoid: Search', lang: 'Ruby', repos: %w(aaw/mongoid_fulltext mauriciozaffari/mongoid_search), description: ""},
  {name: 'Music: Office Radio', lang: 'Ruby', repos: %w(play/play), description: "Music makes the heart shine."},

  # N

  # O
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

  # R
  # Rails
  {name: 'Rails: Bootstrap your project', lang: 'Ruby', repos: %w(jeriko/app_drone RailsApps/rails_apps_composer RailsApps/rails3-application-templates kfaustino/rails-templater renderedtext/base-app intridea/rails_wizard dfischer/Rails-3-Quickstart-Compass--Haml--Sass--SCSS russfrisch/h5bp-rails greendog99/greendog-rails-template cwsaylor/rails3-quickstart), description: "Rails App Generators and Templates. Get you off the ground quickly by bringing in sensible defaults. Templates, Blueprints, Project Generators"},
  {name: 'Rails: Generators for Popular Gems', lang: 'Ruby', repos: %w(ryanb/nifty-generators indirect/rails3-generators leogalmeida/slim-rails indirect/haml-rails), description: ""},

  # S
  # Styling
  {name: 'Images: Sprite Generators', lang: 'Ruby', repos: %w(jakesgordon/sprite-factory), description: ""},

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
  {name: 'Node: Guides / Styleguides', lang: 'JS', repos: %w(felixge/nodeguide.com), description: ''},


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
  {name: 'Stylesheets: SASS Mixin Libraries', lang: 'Design', repos: %w(thoughtbot/bourbon), description: ""},
  {name: 'Views: CSS Preprocessors', lang: 'Design', repos: %w(nex3/sass chriseppstein/compass cowboyd/less.rb cloudhead/less.js), description: "Still writing plain CSS? Consider using SASS, Less, Stylus or any other preprocessor. They generally give you advanced features like variables, mixins, color functions and more. For some of them there are great mixin libraries available."},
  {name: 'Design Frameworks', lang: 'Design', repos: %w(twitter/bootstrap zurb/foundation h5bp/html5-boilerplate necolas/normalize.css joshuaclayton/blueprint-css), description: "Build great looking websites with ease."},



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
]
=end
