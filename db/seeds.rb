# Seeds

# Remove all services
Service.destroy_all

##
# Payments
stripe = Service.create! do |s|
  s.name = "Stripe"
  s.display_url = "stripe.com"
  s.target_url = "https://stripe.com"
  s.description = "Payments for developers. Stripe makes it
    easy for developers to accept credit cards on the web."
end

braintree = Service.create! do |s|
  s.name = "Braintree"
  s.display_url = "braintreepayments.com"
  s.target_url = "https://www.braintreepayments.com"
  s.description = "Braintree is a smarter way to accept credit
    cards online. Start using our easy to implement payment
    gateway today."
end

recurly = Service.create! do |s|
  s.name = "Recurly"
  s.display_url = "recurly.com"
  s.target_url = "http://www.recurly.com"
  s.description = "Recurly provides recurring billing management as a service
    to over one thousand subscription-based companies worldwide."
end

chargify = Service.create! do |s|
  s.name = "Chargify"
  s.display_url = "chargify.com"
  s.target_url = "http://chargify.com"
  s.description = "Chargify simplifies recurring billing for Web 2.0 and SaaS companies.
    Build innovative web applications without worrying how to bill your customers."
end

payments = Category.find('working-with-payments-ruby')

payments.services << stripe
payments.services << braintree
payments.services << recurly
payments.services << chargify

##
# A/B Testing
optimizely =  Service.create! do |s|
  s.name = "Optimizely"
  s.display_url = "optimizely.com"
  s.target_url = "https://www.optimizely.com"
  s.description = "Improve conversions through A/B Testing.
    Split Testing and Multivariate Testing with Optimizely!"
end

visual_website_optimizer =  Service.create! do |s|
  s.name = "Visual Website Optimizer"
  s.display_url = "visualwebsiteoptimizer.com"
  s.target_url = "http://www.visualwebsiteoptimizer.com"
  s.description = "A/B Testing with two or more different
    versions of your website. See which one performs better."
end

a_b_testing = Category.find('a-b-testing-ruby')

a_b_testing.services << optimizely
a_b_testing.services << visual_website_optimizer

##
# Hosting and deployment
heroku = Service.create! do |s|
  s.name = "Heroku"
  s.display_url = "heroku.com"
  s.target_url = "https://www.heroku.com"
  s.description = "Heroku is the leading open language cloud
    application platform and supports Ruby, Node.js, Python
    and apps in many more languages."
end

engine_yard = Service.create! do |s|
  s.name = "Engine Yard"
  s.display_url = "engineyard.com"
  s.target_url = "https://www.engineyard.com"
  s.description = "Engine Yard is the leading cloud platform
    for Ruby on Rails and PHP. Trust Engine Yard's automation,
    service and expertise to build, deploy and run your
    applications online."
end

##
# Ad servers
buy_sell_ads_pro = Service.create! do |s|
  s.name = "BuySellAds Pro"
  s.display_url = "pro.buysellads.com"
  s.target_url = "http://pro.buysellads.com"
  s.description = "We bring together your direct sales, ad serving,
    CRM, and overall monetization management into one powerful interface."
end

##
# Phone and SMS
twilio = Service.create! do |s|
  s.name = "Twilio"
  s.display_url = "twilio.com"
  s.target_url = "http://www.twilio.com"
  s.description = "Twilio lets you use standard web languages to build
    voice, VoIP and SMS applications via the web. Build the next generation
    of communications with us."
end

forty_six_elks = Service.create! do |s|
  s.name = "46elks"
  s.display_url = "46elks.com"
  s.target_url = "http://www.46elks.com"
  s.description = "46elks is a cloud communications platform which makes it
    very easy to integrate Voice and SMS into your applications."
end

nexmo = Service.create! do |s|
  s.name = "Nexmo"
  s.display_url = "nexmo.com"
  s.target_url = "http://nexmo.com"
  s.description = "Nexmo is a simple API to push SMS at wholesale rates
    with high deliverability. Reach over 4 billion mobiles in more than 200 countries."
end

clockwork_sms = Service.create! do |s|
  s.name = "Clockwork SMS"
  s.display_url = "clockworksms.com"
  s.target_url = "http://clockworksms.com"
  s.description = "Clockwork is an easy text message API. An SMS API
    just for developers. Build powerful apps and include SMS.
    Signup is free, try it now."
end

##
# Transactional email
sendgrid = Service.create! do |s|
  s.name = "Sendgrid"
  s.display_url = "sendgrid.com"
  s.target_url = "http://sendgrid.com"
  s.description = "Learn why more developers choose SendGrid's SMTP relay services
    to deliver transactional emails triggered by web apps. Sign up for a free account today."
end

mandrill = Service.create! do |s|
  s.name = "Mandrill"
  s.display_url = "mandrill.com"
  s.target_url = "http://mandrill.com"
  s.description = "Mandrill is a new way for apps to send transactional email.
    It runs on the delivery infrastructure that powers MailChimp."
end

##
# Server monitoring
new_relic = Service.create! do |s|
  s.name = "New Relic"
  s.display_url = "newrelic.com"
  s.target_url = "http://newrelic.com"
  s.description = "Pinpoint and solve performance issues in your Ruby, Java,
    .NET, PHP, Python, iOS and Android apps with real user, application and server monitoring."
end

scout_app = Service.create! do |s|
  s.name = "Scout"
  s.display_url = "scoutapp.com"
  s.target_url = "http://scoutapp.com"
  s.description = "The easier way to monitor servers and web applications.
    Monitor server load, watch for slow web requests, graph internal application data and much more."
end

server_density = Service.create! do |s|
  s.name = "Server Density"
  s.display_url = "serverdensity.com"
  s.target_url = "http://www.serverdensity.com"
  s.description = "Server monitoring as a service. CPU, memory, disk, network, Apache, MongoDB,
    MySQL + more. E-mail/SMS alerts. iPhone/Android server monitoring apps."
end

##
# Cloud cost management
cloudability = Service.create! do |s|
  s.name = "Cloudability"
  s.display_url = "cloudability.com"
  s.target_url = "https://cloudability.com/"
  s.description = "Cloud spending: under control. Give your engineering, finance and
    management teams the visibility they need into your cloud costs and usage."
end

##
# Code qualtiy
code_climate = Service.create! do |s|
  s.name = "Code Climate"
  s.display_url = "codeclimate.com"
  s.target_url = "https://codeclimate.com"
  s.description = "Code Climate hosted software metrics help you ship quality Ruby code faster.
    Get control of your technical debt with real time static analysis of your code."
end

coveralls = Service.create! do |s|
  s.name = "Coveralls"
  s.display_url = "coveralls.io"
  s.target_url = "https://coveralls.io"
  s.description = "Ensure that all your new code is fully covered, and see coverage trends emerge.
    Works with any CI service. Always free for open source."
end

code_quality = Category.find('code-quality-metrics-ruby')

code_quality.services << code_climate
code_quality.services << coveralls

##
# Learning stuff
railscasts = Service.create! do |s|
  s.name = "RailsCasts"
  s.display_url = "railscasts.com"
  s.target_url = "http://railscasts.com"
  s.description = "Short Ruby on Rails screencasts containing tips, tricks and tutorials.
    Great for both novice and experienced web developers."
end

ruby_tapas = Service.create! do |s|
  s.name = "RubyTapas"
  s.display_url = "rubytapas.com"
  s.target_url = "http://www.rubytapas.com"
  s.description = "RubyTapas is for the busy Ruby or Rails developer who is ready
    to reach the next level of code mastery."
end

treehouse = Service.create! do |s|
  s.name = "Treehouse"
  s.display_url = "teamtreehouse.com"
  s.target_url = "http://teamtreehouse.com"
  s.description = "Treehouse is the fastest, easiest way to learn to code, make apps, and start a business.
    Tutorials in CSS, HTML, Ruby, JavaScript, iOS, and more."
end

# railscasts = Service.create! do |s|
#   s.name = ""
#   s.display_url = ""
#   s.target_url = ""
#   s.description = ""
# end
