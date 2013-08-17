class Link
	include DataMapper::Resource

	validates_with_method :url_key, :method => :valid_url_key? 
	validates_format_of :url, :as => :url

	def valid_url_key?
		if @url_key =~ /^admin/
			return [false, "URL Key Cannot Begin With \"admin\""]
		elsif @url_key =~ /^s\// or @url_key == "s"
			return [false, "This URL is already a shortened key."]
		elsif @url_key =~ /^\S+$/
			return true
		else
			return [false, "URL Key Cannot Contain Whitespace"]
		end
	end
	# property <name>, <type>
	property :id, Serial
	property :url_key, String
	property :url, String
	
	before :update do |link|
		old_link = Link.get(link.id)
		
		if old_link.url_key != link.url_key
			if File.exists? "#{Padrino.root}/public/#{old_link.url_key}/index.html"
				File.unlink "#{Padrino.root}/public/#{old_link.url_key}/index.html"
				Dir.rmdir "#{Padrino.root}/public/#{old_link.url_key}"				
			end
		end
	end
	
	# Add in cache support:
	after :save, :update do |link|
		if File.writable? "#{Padrino.root}/public/"
			if !File.exist? "#{Padrino.root}/public/#{link.url_key}"
				Dir.mkdir "#{Padrino.root}/public/#{link.url_key}"
			end
			File.open("#{Padrino.root}/public/#{link.url_key}/index.html", "w") { |f| f.write("<html><head><meta http-equiv=\"refresh\" content=\"0; url=#{link.url}\"><script type=\"text/javascript\">window.location.href=\"#{link.url}\";</script></head><body></body></html>")}
		end
	end
	
	before :destroy do |link|
		if File.exists? "#{Padrino.root}/public/#{link.url_key}/index.html"
			File.unlink "#{Padrino.root}/public/#{link.url_key}/index.html"
			Dir.rmdir "#{Padrino.root}/public/#{link.url_key}"
		end
	end
end
