class Link
  include DataMapper::Resource

  validates_format_of :url_key, :as => /^\S+$/
  validates_format_of :url, :as => :url

  # property <name>, <type>
  property :id, Serial
  property :url_key, String
  property :url, String
end
