class Booking
  include DataMapper::Resource

  belongs_to :space
  belongs_to :user
  property :id, Serial
  property :check_in_date, Date
  property :check_out_date, Date
  
end
