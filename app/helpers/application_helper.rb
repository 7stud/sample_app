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

  #Return site logo:
  def logo
    image_tag("autumn.jpg", :size => "300x140", :alt => "Autumn", :class => "round")
  end

end
