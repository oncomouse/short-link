migration 4, :create_shorties do
	up do
		create_table :shorties do
			column :id, Integer, :serial => true
			column :url, DataMapper::Property::String, :length => 255
		end
	end

	down do
		drop_table :shorties
	end
end
