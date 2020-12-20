# Theme Changer plugin for Redmine
# Copyright (C) 2010-2018  Haruyuki Iida
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

Redmine::Plugin.register :redmine_theme_changer do
  name 'Redmine Theme Changer plugin'
  author 'Haruyuki Iida'
  description 'Lets each user select a theme for Redmine'
  version '0.4.1'
  url 'http://www.redmine.org/plugins/redmine_theme_changer'
  author_url 'http://twitter.com/haru_iida'
  requires_redmine :version_or_higher => '4.0.0'
end

Rails.configuration.to_prepare do
  require_dependency 'theme_changer_my_account_hooks'
  require_dependency 'theme_changer_user_patch'
  require_dependency 'theme_changer_themes_patch'

  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  require_dependency 'user_preference'
  UserPreference.send(:prepend, ThemeChangerUserPreferencePatch)
end

