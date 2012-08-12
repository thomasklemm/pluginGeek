# encoding: UTF-8
# production/children.seeds.rb

###
###  Children can be updated here
###

Rails.logger.info 'Processing parents/children...'
after 'production:categories' do
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

  # Seed Children Plugins
  plugins.each do |plugin|
    # Children
    # ( Makes sure children are known if they aren't listed in any category and thus not seeded yet )
    plugin[:children].each { |full_name| Repo.find_or_create_by_full_name(full_name) }

    # Write 'Association'
    parent = Repo.find_or_initialize_by_full_name(plugin[:parent])
    parent.child_list = plugin[:children].join(', ')
    parent.save
  end
end
Rails.logger.info 'Finished processing parents/children'