class Request
  include DataMapper::Resource

  belongs_to :space
  belongs_to :user
  property :id, Serial
  property :check_in_date, Date, required: true
  property :check_out_date, Date, required: true
  property :request_status, String

end
