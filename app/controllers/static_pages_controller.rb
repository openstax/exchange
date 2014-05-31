# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

class StaticPagesController < ApplicationController

  layout :resolve_layout

  skip_protect_beta :only => [:status]
  skip_before_filter :authenticate_user!
  skip_interceptor :registration, :only => [:status]
  fine_print_skip_signatures :general_terms_of_use,
                             :privacy_policy

  def home
  end

  def api
  end

  def about
  end

  # Used by AWS (and others) to make sure the site is still up.
  def status
    head :ok
  end

protected

  def resolve_layout
    'home' == action_name ? 'application_home_page' : 'application_body_only'
  end

end