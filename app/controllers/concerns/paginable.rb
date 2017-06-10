module Paginable
  extend ActiveSupport::Concern

  def paginate
    page = params[:page]
    page = 1 unless !!(page.to_s =~ /\A[0-9]+\z/)
    collection = yield page
    collection.tap do
      if collection.current_page <= collection.total_pages
        links = []
        url = request.original_url.sub /\?.*$/, ''
        Paginator.new(collection).pages.each do |rel, page|
          new_params = request.query_parameters.merge page: page
          links << %(<#{url}?#{new_params.to_param}>; rel="#{rel}")
        end
        headers['Link'] = links.join ', ' unless links.empty?
      end
    end
  end
end
