class Shorty
	include DataMapper::Resource

	validates_format_of :url, :as => :url

	# property <name>, <type>
	property :id, Serial
	property :url, String
end
