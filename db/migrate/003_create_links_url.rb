migration 3, :create_links_url do
  up do
	drop_table :links
    create_table :links do
      column :id, Integer, :serial => true
      column :url_key, DataMapper::Property::String, :length => 255
      column :url, DataMapper::Property::String, :length => 255, :format => :url
    end
  end

  down do
    drop_table :links
    create_table :links do
      column :id, Integer, :serial => true
      column :url_key, DataMapper::Property::String, :length => 255
      column :url, DataMapper::Property::String, :length => 255
    end
  end
end