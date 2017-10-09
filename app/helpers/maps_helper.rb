module MapsHelper

  def map_category_link(category)
    link_to category.titleize.gsub("Rank", ""), maps_path(category: category), remote: true
  end

  def overall_rank_link
    link_to "Overall Rank", get_overall_rank_path, remote: true
  end

  def maps_tab_class(tab_name, current_category)
    "active" if tab_name == current_category
  end
end
