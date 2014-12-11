# Copyright 2013-2014 Rice University. Licensed under the Affero General
# Public License version 3 or later.  See the COPYRIGHT file for details.

module ApplicationFooterHelper

  def copyright_text
    OpenStax::Utilities::Text.copyright(COPYRIGHT_START_YEAR, COPYRIGHT_HOLDER)
  end

end
