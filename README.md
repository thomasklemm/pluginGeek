# pluginGeek [ ![Code Climate](https://codeclimate.com/github/thomasklemm/pluginGeek.png)](https://codeclimate.com/github/thomasklemm/pluginGeek)[ ![Coverage Status](https://coveralls.io/repos/thomasklemm/pluginGeek/badge.png?branch=master)](https://coveralls.io/r/thomasklemm/pluginGeek)

[pluginGeek](http://www.plugingeek.com) is your web development toolbox, reimagined.

### Why?

Many of you who read this might be web developers. We're constantly facing demands an what to achieve next, and often could be helped quite a lot in our daily job by finding the best resources and plugins to ease our pain right away. You remember that nice gem you stumbled upon two weeks ago, with the blueish website. What was it called again?!

### How?

pluginGeek is an open-source Rails wiki on the state of the art gems and plugins in a few different, web-related programming languages and realms. We cover [Ruby gems](http://www.plugingeek.com/ruby), [Javascript and jQuery plugins](http://www.plugingeek.com/javascript), repositories related to [Webdesign](http://www.plugingeek.com/webdesign) as our web development categories from the start. If you're a mobile developer, you can boost your apps with the latest [iOS](http://www.plugingeek.com/ios) and [Android](http://www.plugingeek.com/android) libraries. Find what you look for in an instant, and if you know about other noteworthy repositories and links related to any available or new category, just add them. Your fellow developers will like you for it!

### Inspirations and alternatives

pluginGeek is certainly not the first of its kind. I've drawn a lot of inspiration from great sites including the [Ruby Toolbox](https://www.ruby-toolbox.com/), the phenomenal [Unheap](http://www.unheap.com/), and many more sites. Occasionally I cross-reference the inventory to make sure you'll always find the latest gems and plugins right at your hand.

### Technology

pluginGeek is Rails app fueled by a lot of [amazing gems](https://github.com/thomasklemm/pluginGeek/blob/master/Gemfile). The staging and [production apps](http://www.plugingeek.com) are deployed to [Heroku](http://www.heroku.com), one of my favorites services for developers.

### Testing

pluginGeek uses [RSpec](https://github.com/rspec/rspec-rails) flavored with [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers). [Fabrication](http://www.fabricationgem.org/) helps with replacing fixtures and generating test objects. [Timecop](https://github.com/travisjeffery/timecop) makes time-related testing easy. [VCR](https://github.com/vcr/vcr) helps with recording and replaying external HTTP requests.  [Capybara](https://github.com/jnicklas/capybara) powers the feature specs.

In all the current test suite holds more than 700 examples and runs in about 35 seconds on a standard MacBook Pro of 2010.

![Test output](http://i.imgur.com/OCdit8N.png) [ ![Coverage Status](https://coveralls.io/repos/thomasklemm/pluginGeek/badge.png?branch=master)](https://coveralls.io/r/thomasklemm/pluginGeek)

### Stats

![Rake stats](http://i.imgur.com/iQt9F7X.png)

### Learning

pluginGeek's source is intended to be nicely readable and comprehensible even if you are just getting started with Ruby on Rails development. There's a variety of annotations guiding you around.

It's certainly not the most complex app ever, and a variety of annotations should help people just starting with web development - as myself about one and a half years ago - find their way around and learn from some existing code really quickly. Modeling an existing app on my own alongside the original authors' source has been fruitful for me in picking up new skills and styles, general coding techniques and best practices.

### Questions?

If you have any questions or would just like to talk, feel free to get in touch. I'm [thomasklemm](https://github.com/thomasklemm) here on Github, [@thomasjklemm](https://twitter.com/thomasjklemm) on Twitter.

#### Licence
MIT, 2013, Thomas Klemm (*github__at__tklemm__dot__eu*)
