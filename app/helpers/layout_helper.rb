# Copyright 2011-2014 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

module LayoutHelper

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

  def copyright_text
    OpenStax::Utilities::Text.copyright(COPYRIGHT_START_YEAR, COPYRIGHT_HOLDER)
  end

end
