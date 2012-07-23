DESCRIPTIONS FOR LAUNCHING KNIGHT.IO

Git
Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.

Docs & Reading:
- [Git Homepage (git-scm.com)](http://git-scm.com/)
- [Pro Git]http://git-scm.com/book) - Book (free online)
- [Git Reference](http://git-scm.com/docs)
- [A Successful Git Branching Model](http://nvie.com/posts/a-successful-git-branching-model/)

Learning by Doing:
- [tryGit](http://try.github.com/) - Free Git Course by Github & CodeSchool

Screencasts:
- [Git](http://git-scm.com/videos)
- [How to use a scalable Git Branching Model called git-flow](http://buildamodule.com/video/change-management-and-version-control-deploying-releases-features-and-fixes-with-git-how-to-use-a-scalable-git-branching-model-called-gitflow)

--------------------------------------------------

LEARNING: Ruby
SD:

HD:


Docs & Reading:

-----------

Learning: Rails
Ruby on Rails is an open-source web framework that's optimized for programmer happiness and sustainable productivity. I lets you write beautiful code by favoring convention over configuration.

Docs & Reading:
- [Ruby on Rails Documentation](http://api.rubyonrails.org/)
- [Rails Guides](http://guides.rubyonrails.org/)
- [Agile Web Development with Ruby on Rails](http://pragprog.com/book/rails4/agile-web-development-with-rails) - The Standard Book on Ruby on Rails Development; is kept up to date with the current Rails version

Screencasts:
- [RailsCasts](http://railscasts.com/)

------------------------------------------

Background Jobs:
Background jobs are key to building truly scalable web apps as they transfer both time and computationally intensive tasks from the web layer to a background process outside the user request/response lifecycle. This ensures that web requests can always return immediately and reduces compounding performance issues that occur when requests become backlogged.

Docs & Reading:
- [Background Processing vs. Message Queueing](http://www.mikeperham.com/2011/05/04/background-processing-vs-message-queueing/) by [Mike Perham (@mperham)](https://twitter.com/mperham)
- [Worker Dynos, Background Jobs and Queuuing](https://devcenter.heroku.com/articles/background-jobs-queueing)

RailsCasts:
- [Sidekiq](http://railscasts.com/episodes/366-sidekiq) - Sidekiq allows you to move jobs into the background for asynchronous processing. It uses threads instead of forks so it is much more efficient with memory compared to Resque.
- [Resque](http://railscasts.com/episodes/271-resque) - Resque creates background jobs using Redis. It supports multiple queue and comes with an administration interface for monitoring and managing the queues.
- [Delayed Job (revised)](http://railscasts.com/episodes/171-delayed-job-revised) - Long requests should be moved into a background process, and Delayed Job is one of the easiest ways to do this because it works with an Active Record database.
- [Queue Classic](http://railscasts.com/episodes/344-queue-classic) - PostgreSQL can act as a worker queue which can replace the need for a separate process to manage the background jobs. Here you will learn how to do this with the queue_classic gem.
See [Background Jobs: Scheduling & Recurring Jobs](#) for RailsCasts on Recurring Jobs & Schedulting

----------

Background Jobs: Scheduling Jobs & Recurring Events

Schedule recurring work at particular Times or Dates.

Docs & Reading:
- [Heroku Scheduler](https://devcenter.heroku.com/articles/scheduler) - Scheduler is a Heroku add-on for running jobs on your app at scheduled time intervals, much like cron in a traditional server environment.

RailsCasts:
- [Cron in Ruby (revised)](http://railscasts.com/episodes/164-cron-in-ruby-revised) - Cron is a common solution for recurring jobs, but it has a confusing syntax. In this episode I show you how to use Whenever to create cron jobs using Ruby. Some alternative scheduling solutions are also mentioned.


------------

Deployment & Hosting

Docs & Reading:
- [Deploying Rails: Automate, Deploy, Scale, Maintain and Sleep at Night](http://pragprog.com/book/cbdepra/deploying-rails) - Today’s modern Rails applications have lots of moving parts. Make sure your next production deployment goes smoothly with this hands-on book, which guides you through the entire production process. You’ll set up scripts to install and configure all the software your servers need, including your application code. Once you’re in production, you’ll learn how to set up systems to monitor your application’s health, gather metrics so you can stop problems before they start, and fix things when they go wrong; released 2012-07-20.

RailsCasts:
- [Rubber and Amazon EC2](http://railscasts.com/episodes/347-rubber-and-amazon-ec2)
- [Capistrano Tasks (revised)](http://railscasts.com/episodes/133-capistrano-tasks-revised)

---

ActiveRecord: Searching 

Full-Text Searching.

RailsCasts:
- [Search with Sunspot](http://railscasts.com/episodes/278-search-with-sunspot) - Sunspot makes it easy to do full text searching through Solr. Here I show how to search on various attributes and add facets for filtering the search further.
- [Thinking Sphinx (revised)](http://railscasts.com/episodes/120-thinking-sphinx-revised) - Sphinx is a full-text search engine for use with MySQL or PostgreSQL. Learn how to add Thinking Sphinx by defining an index on your model and searching with various options.
- [Full-Text Search in PostgreSQL](http://railscasts.com/episodes/343-full-text-search-in-postgresql) - Postgres offers full-text searching right out of the box. This episode shows how to write queries from scratch, apply tools like Texticle and pg_search, and optimize performance through indexes.
- [ElasticSearch Part 1](http://railscasts.com/episodes/306-elasticsearch-part-1) - Add full text searching using ElasticSearch and Tire. Here I will show the steps involved in adding this search to an existing application. This is the first part in a two part series.
- [ElasticSearch Part 2 (pro)](http://railscasts.com/episodes/307-elasticsearch-part-2) - This final part on ElasticSearch and Tire will show how to make more complex search queries, customize the indexing, and add facets.
- [Advanced Search Form (revised)](http://railscasts.com/episodes/111-advanced-search-form-revised) - It is often best to use a GET request when submitting a search form, however if it is an advanced search form with a lot of fields then this may not be ideal. Here I show how to create a search resource to handle this.

Related: [ActiveRecord: Scopes](#)

----------

ActiveRecord: Scopes

A scope represents a narrowing of a database query. Named scopes help organize these filters.

Docs & Reading:
- [Named Scopes](http://api.rubyonrails.org/classes/ActiveRecord/Scoping/Named/ClassMethods.html) - Rails API Docs (includes Examples)
- [Default Scoping](http://api.rubyonrails.org/classes/ActiveRecord/Scoping/Default/ClassMethods.html) - Rails API Docs

RailsCasts:
- [Squeel](http://railscasts.com/episodes/354-squeel) - Squeel provides a comprehensive DSL for writing SQL queries in Ruby. It is built upon Arel giving you access to many of its powerful features.
- [Hacking with Arel (pro)](http://railscasts.com/episodes/355-hacking-with-arel) - Learn about a variety of ways to rewrite a long SQL query using only Active Record and Arel. This includes generating scopes dynamically, adding an "or" operator, and adding a powerful "match" method.

Related: [ActiveRecord: Searching](#)

---------------

Deployment: Domains & DNS

In order to make your application accessible to the world through a domain name like [knight.io](http://knight.io), you need to register a domain with a provider.

Providers with good user interfaces:
- [Gandi](https://www.gandi.net/)
- [DNSimple](https://dnsimple.com/)

If you already have a domain but are with a provider that doesn't allow you to use subdomains or other features, you might consider using [Amazon Route 53](http://aws.amazon.com/route53/) as your Nameserver.

Docs & Reading
- [Custom Domains on Heroku](https://devcenter.heroku.com/articles/custom-domains)
- [List of DNS Record Types (Wikipedia)](http://en.wikipedia.org/wiki/List_of_DNS_record_types)
- [Time-to-live (TTL) of DNS Records (Wikipedia)](http://en.wikipedia.org/wiki/Time_to_live)

---

Web Application Frameworks

Web App Frameworks give you a lot of tools to speed you up with web development. A full-stack framework typically includes a data query abstraction language, a routing & view templating system, helpers for formatting view output, Internationalization APIs and more. A lower-level framework usually provides you with an easy way to routes and process web requests.

[Ruby on Rails](http://rubyonrails.org/), often shortened to Rails, is the open source full-stack web application framework for the Ruby programming language. Rails is perhaps the most widely used Ruby framework today, with good reason. Rails was extracted from [37signals' Basecamp](http://basecamp.com/) and powers Github, Shopify, Twitter & many other popular Web Services. Part of what makes Rails great is the vibrant ecosystem, with a lot of great programmers creating and maintaining valuable gems.

[Sinatra](http://www.sinatrarb.com/) is small and flexible. It does not follow the typical model–view–controller pattern used in other frameworks, such as Ruby on Rails. Instead, Sinatra focuses on "quickly creating web-applications in Ruby with minimal effort."


Docs & Reading:
- ... is waiting for you on any framework's homepage

Related Categories:
- [Learning Rails]() - Tons of resources waiting to help you get better at Rails development

---

Frameworks: Static Site Frameworks

Build & Design a site in your favorite templating language and using CSS and JS preprocessors. Serve the compiled static HTML, CSS & JS.

Docs & Reading:
- [Using Jekyll and GitHub Pages for a Static Site](http://developmentseed.org/blog/2011/09/09/jekyll-github-pages/)
- [Github Pages](http://pages.github.com/) - Can be used for hosting a static Jekyll site for free

Related Categories
- [Blogging Engines](#)

-----

User Management: Authentication

**User authentication is required in almost every application.**

Authenticating Users typically involves setting up a user model, sessions controller, login & logout views, cookie handling etc. and can be extended to allow users to authorize from external services such as Twitter or Facebook. 

If this is the first time you are involved in authentication, Ryan Bates ([RailsCasts](http://railscasts.com/)) recommends building authentication from scratch to get to know the many details and moving parts that are involved in this matter. The RailsCasts listed below are a great place to start.

[REPOS]

# Related Categories:
- [**User Management: Authorization**](http://knight.dev/categories/users-authorization-ruby) - Restrict what resources a user is allowed to access.

# Docs & Reading:
- [**Rails authentication today: Options for 3.0 and 3.1**](http://everydayrails.com/2011/09/21/rails-authentication.html) - A look at the current Rails authentication landscape (published 09/2011)
- [**OAuth 2.0**](http://oauth.net/2/) - OAuth 2.0 is the next evolution of the OAuth protocol which was originally created in late 2006. OAuth 2.0 focuses on client developer simplicity while providing specific authorization flows for web applications, desktop applications, mobile phones, and living room devices.

# RailsCasts:
- [**Authentication from Scratch** (revised)](http://railscasts.com/episodes/250-authentication-from-scratch-revised) - Simple password authentication is easy to do with has_secure_password. Here you will learn how to make a complete Sign Up, Log In, and Log Out process as well as restrict access to certain actions.
- [**Authentication with Sorcery**](http://railscasts.com/episodes/283-authentication-with-sorcery) - Sorcery is a full-featured, modular solution to authentication which leaves the controller and view layers up to you.
- [**Authentication in Rails 3.1**](http://railscasts.com/episodes/270-authentication-in-rails-3-1) - Here I show off three new features in Rails 3.1 that will help with authentication: easier HTTP Basic Authentication, SecurePassword in the database, and forcing SSL.
- [**Authentication from Scratch** (free)](http://railscasts.com/episodes/250-authentication-from-scratch) - Password authentication is not too complicated to make from scratch, it will also help to get a better understanding of how it works.
- [**All 20+ RailsCasts on Authorization** & Authorizing through an external provider &raquo;](http://railscasts.com/?tag_id=25)

-----

Form Builders

Form Builders let you generate complex forms with simple markup. Some include options to do client-side validation using JS or HTML5 by extracting your model's validation rules, other cohere with a certain markup structure so that i.e. Twitter Bootstrap styling is automatically applied.

You should get familiar with the built-in [Rails Form Helpers](http://guides.rubyonrails.org/form_helpers.html) before deciding to use any additional Form Builder.

Docs & Reading:
- [Rails Form Helpers](http://guides.rubyonrails.org/form_helpers.html) - Forms in web applications are an essential interface for user input. However, form markup can quickly become tedious to write and maintain because of form control naming and their numerous attributes. Rails deals away with these complexities by providing view helpers for generating form markup. However, since they have different use-cases, developers are required to know all the differences between similar helper methods before putting them to use.
- [ActionView Form Helper](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html) - from the [Rails API Docs](http://api.rubyonrails.org/)

RailsCasts:
- [Form Builders](http://railscasts.com/episodes/311-form-builders) - Forms often follow a similar pattern with a lot of repetition. Learn how to clean up form views and remove duplication with the help of form builders.
- [Nested Model Form (revised)](http://railscasts.com/episodes/196-nested-model-form-revised) - Handling multiple models in a single form is easy with accepts_nested_attributes_for. Here you will also learn how to add and remove nested records through JavaScript.
- [All 30+ RailsCasts on Forms](http://railscasts.com/?tag_id=15)

----

CMS

A Content Management System provides content authoring and adminstration tools to allow users with little knowledge of programming languages to edit a website's contents with relative ease. Visual File Uploads and Image Embedding are also part. The world's most known CMS (and blogging engine) is probably [Wordpress](http://wordpress.org/) (written in PHP).

If you want someone else to edit or translate just a few strings, have a look at thoughtbot's [Copycopter](http://copycopter.com/).

Related Categories:
- [Frameworks: Static Site Generators] - ...
- [Apps: Blogging Engines] - ...
- [Apps: Translation Interfaces] - ...

---

Ruby Implementations

Implementations of the Ruby Language for a variety of platforms and use cases.

Ruby MRI (Matz's Ruby Interpreter) is has been the de facto standard Ruby implementation until the specification of the Ruby language in 2011. Nowadays however, several mature implementations exist and are used by various companies in production. Among them are JRuby and Rubinius, both providing just-in-time compilation in their respective environments. RubyMotion brings Ruby to iOS, while mruby is aiming to become an embeddable Ruby runtime.

Docs & Reading:
- [Ruby MRI, JRuby and Rubinius Brodown](http://www.engineyard.com/blog/2011/ruby-mri-jruby-and-rubinius-throwdown-brodown/)
- [EngineYard - Deploy JRuby applications](http://www.engineyard.com/documentation/jruby)
- [EngineYard - Use Rubinius with Engine Yard Cloud](http://www.engineyard.com/documentation/rubinius)

---

Blogging Engines
No need to explain Blogging, is there?
---
Forms: File Uploads
Upload files to your app or a cloud storage service such as Amazon S3. Process images and videos on-thy-fly.
----
Admin Interfaces
Administration Frameworks for Rails apps.
---


--------

Deployment: Hosting Providers


-----

Deployment: Deploying to a Cloud Server / Cloud Service

fog puppet chef chef-knife

-----
###########
TODO:
###########

ActionMailer: Preview Emails

Preview the Emails you would be sending in your development environment instead of actually sending them.

----

Users: Authorization

Restrict what resources a given user is allowed to access.

---