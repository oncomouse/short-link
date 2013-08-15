class Link
	include DataMapper::Resource

	validates_with_method :url_key, :method => :valid_url_key? 
	validates_format_of :url, :as => :url

	def valid_url_key?
		if @url_key =~ /^admin/
			return [false, "URL Key Cannot Begin With \"admin\""]
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
end
