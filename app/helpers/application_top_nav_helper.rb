# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

module ApplicationTopNavHelper

  def top_nav_active(name)
    content_for "top_nav_#{name}_current".to_sym do
      top_nav_current_link_class
    end
  end

  def top_nav_current_link_class
    "current "
  end

  def top_nav_home_page_background
    content_for :top_nav_class do
      "home-page "
    end
  end
end
