module ShortLinks
  class App < Padrino::Application
    register SassInitializer
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers

    #register Padrino::Cache
    #enable :caching

    enable :sessions

	@@default_url = "http://andrew.pilsch.com"
	
	
	get '/s/' do
	end
	
	get :shorty, :map => '/s/:url_key' do
		shorty = Shorty.get(Base62.to_i params[:url_key])
		if shorty.nil?
			halt(404)
		else
			redirect shorty.url
		end
	end
	
	get :link, :map => '/:url_key' do
		# Rudimentary cache support:
		# Files are now created when a link is created and updated. These pages are rudimentary HTML redirects.
		# This saves having to ping the database for every page request (as the data doesn't change often).
		if File.exists? "#{Dir.pwd}/public/_#{params[:url_key]}.html"
			File.read("#{Dir.pwd}/public/_#{params[:url_key]}.html")
		else
			link = Link.first(:url_key => params[:url_key])
			if link.nil?
				redirect "#{@@default_url}/#{params[:url_key]}"
			else
		
				redirect link.url
			end
		end	
	end
	
	get '/' do
		redirect @@default_url
	end

    ##
    # Caching support
    #

    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))
    # set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
    # set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
    # set :cache, Padrino::Cache::Store::Memory.new(50)
    # set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #

    ##
    # You can manage errors like:
    #
    #   error 404 do
    #     render 'errors/404'
    #   end
    #
    #   error 505 do
    #     render 'errors/505'
    #   end
    #
  end
end
