# Theme Changer plugin for Redmine
# Copyright (C) 2010-2015  Haruyuki Iida
#rev
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require 'redmine'
require 'theme_changer_my_account_hooks'
require 'theme_changer_user_patch'
require 'theme_changer_themes_patch'

Rails.configuration.to_prepare do
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  require_dependency 'user_preference'
  unless UserPreference.included_modules.include? ThemeChangerUserPreferencePatch
    UserPreference.send(:include, ThemeChangerUserPreferencePatch)
  end
end

Redmine::Plugin.register :redmine_theme_changer do
  name 'Redmine Theme Changer plugin'
  author 'Haruyuki Iida'
  description 'Lets each user select a theme for Redmine'
  version '0.3.0'
  url 'http://www.r-labs.org/projects/themechanger'
  author_url 'http://twitter.com/haru_iida'
  requires_redmine :version_or_higher => '3.4.0'
end
