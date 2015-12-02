module ApplicationHelper

  def showNotice
    if notice
      "<p id=\"notice\" class=\"alert alert-success\">#{ notice }</p>".html_safe
    end
  end
end
