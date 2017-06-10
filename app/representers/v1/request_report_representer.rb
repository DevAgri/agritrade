module V1
  module RequestReportRepresenter
    include Roar::JSON

    property :total_waiting
    property :total_done
  end
end
