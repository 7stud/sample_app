module ApplicationHelper
  #Return title on a per page basis:
  def title
    base_title = "Grant's website"

    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end    

end
