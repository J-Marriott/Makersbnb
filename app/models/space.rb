class Space
  include DataMapper::Resource

  belongs_to :user
  property :id, Serial
  property :name, String, required: true
  property :description, String, required: true, length: 255
  property :price, Integer, required: true
  property :available_start_date, Date
  property :available_end_date, Date
  has n, :requests
  has n, :bookings

end
