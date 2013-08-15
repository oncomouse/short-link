short-link
==========

Short link is a [Padrino](http://www.padrinorb.com/) application that sits on a top-level domain and does what I'm calling "smart referrals". Basically, when any request comes in, short-link goes through the following steps:

1. Is this an admin request?
1. Is this a request I know about in my database?
1. Forward the request to another domain.

I created this application because I wanted more nuanced control over the way a mobile friendly domain referred to my longer domain (in my case, from http://atp1.us to http://andrew.pilsch.com). Basically, this site lets you create custom referrals, such that http://shortdomain.com/X can forward to wherever you want.

Installation
------------

After cloning, run the following commands:

(Note, if you're using Ruby 1.8.X, change the line `gem 'redcarpet'` to `gem 'redcarpet', '2.3.0'`).

````
bundle install
````

````
padrino rake db:migrate
````

````
padrino rake db:seed
````

After these commands, you need to edit the file `app/app.rb` and change the line `@@default_url = "http://andrew.pilsch.com"` to whatever your default, long URL will be. After that, you should be ready to go.

To start the application, you can run:

````
padrino start
````

For more information on deploying this software, see [Padrino's documentation](http://www.padrinorb.com/guides/blog-tutorial#deploying-our-application) for how to deploy your application.

Usage
-----

The application is driven through the `/admin` interface. When running in development mode (`padrino start`), you can point your browser to http://localhost:3000/admin and log in with the credentials you created when running `rake db:seed`. You can click the "Links" link and then click the "New" tab to begin creating your referrals.

