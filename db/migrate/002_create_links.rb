migration 2, :create_links do
  up do
    create_table :links do
      column :id, Integer, :serial => true
      column :url_key, DataMapper::Property::String, :length => 255
      column :url, DataMapper::Property::String, :length => 255
    end
  end

  down do
    drop_table :links
  end
end
