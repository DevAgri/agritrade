module V1
  module RequestRepresenter
    include Roar::JSON

    property :id
    property :latitude
    property :longitude
    property :status
    property :created_at
    property :owner, extend: RequestOwnerRepresenter
  end
end
