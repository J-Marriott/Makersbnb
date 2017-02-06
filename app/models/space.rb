class Space
  include DataMapper::Resource

  belongs_to :user
  property :id, Serial
  property :name, String, required: true
  property :description, String, required: true, length: 255
  property :price, Integer, required: true
  has n, :requests



=begin sort this
  property :available_dates
  has n, :available_dates
=end
end
