# frozen_string_literal: true

# The base class for all Active Storage controllers.
class ActiveStorage::BaseController < ActionController::Base
  unless Bundler.definition.specs['activestorage'].first.version.eql?(Gem::Version.new('6.0.3.4'))
    raise(LoadError, "#{self} was modified. Make sure to compare it to the original code.")
  end

  before_action :not_found_unless_logged_in!

  include SessionsHelper
  include ActiveStorage::SetCurrent

  protect_from_forgery with: :exception

  private def not_found_unless_logged_in!
    head :not_found unless logged_in?
  end
end
