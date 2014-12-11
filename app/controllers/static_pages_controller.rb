# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

class StaticPagesController < ApplicationController

  layout :resolve_layout

  fine_print_skip :general_terms_of_use, :privacy_policy

  def home
  end

  def api
  end

  def about
  end

protected

  def resolve_layout
    'home' == action_name ? 'application_home_page' : 'application_body_only'
  end

end
