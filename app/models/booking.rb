class Booking
  include DataMapper::Resource

  belongs_to :space
  property :id, Serial
  property :booker_id, Integer
  property :check_in_date, Date
  property :check_out_date, Date
  
end
