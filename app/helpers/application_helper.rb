module ApplicationHelper
  # Return a title on a per-page basis.
  def title
    base_title = ""
    if @title.nil?
      base_title
    else
      "#{@title}"
    end
  end
  
  # Add class="current" to navigation item of current page
  def cp(path)
    "current" if current_page?(path)
  end
  
  def current_course
    @__current_course ||= if session[:course_id]
      current_user.courses.find(session[:course_id])
    else
      current_user.try(:default_course)
    end
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end
end
