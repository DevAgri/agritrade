module V1
  module RequestOwnerRepresenter
    include Roar::JSON

    property :id
    property :first_name
    property :last_name
    property :avatar_image_url
    property :email
  end
end
