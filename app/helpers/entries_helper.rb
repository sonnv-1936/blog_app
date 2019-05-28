module EntriesHelper
  def paginate total_pages
    return unless total_pages > 1
    paginate_element = content_tag :div, ""

    total_pages.times do |page|
      paginate_element << link_to(page + 1, root_path(page: page + 1))
    end

    paginate_element
  end
end
