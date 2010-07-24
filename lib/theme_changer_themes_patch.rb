# Code Review plugin for Redmine
# Copyright (C) 2009  Haruyuki Iida
#
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

#require_dependency 'application_controller'
require_dependency 'redmine/themes'

module ApplicationHelper
  def get_theme
    setting = ThemeChangerUserSetting.find_theme_by_user_id(User.current.id)
    return Setting.ui_theme unless setting
    return Setting.ui_theme if setting.theme == ThemeChangerUserSetting::SYSTEM_SETTING
    return setting.theme_name
  end

  def stylesheet_path(source)
    @current_theme ||= Redmine::Themes.theme(get_theme)
    super((@current_theme && @current_theme.stylesheets.include?(source)) ?
      "/themes/#{@current_theme.dir}/stylesheets/#{source}" : source)
  end

end