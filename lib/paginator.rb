class Paginator
  def initialize(collection)
    @collection = collection
  end

  def pages
    {}.tap do |pages|
      unless @collection.first_page?
        pages[:first] = 1
        pages[:prev]  = @collection.current_page - 1
      end

      unless @collection.last_page?
        pages[:last] = @collection.total_pages
        pages[:next] = @collection.current_page + 1
      end
    end
  end
end
