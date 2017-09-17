# Theme Changer plugin for Redmine
# Copyright (C) 2010-2017  Haruyuki Iida
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
class ThemeChangerUserSetting < ActiveRecord::Base
  unloadable
  belongs_to :user
  validates_presence_of :user

  DEFAULT_THEME = '__default_theme__'
  SYSTEM_SETTING = '__system_setting__'

  def self.find_theme_by_user_id(user_id)
    ThemeChangerUserSetting.find_by(user_id: user_id)
  end

  def self.find_or_create_theme_by_user_id(user_id)
    theme = find_theme_by_user_id(user_id)
    unless theme
      theme = ThemeChangerUserSetting.new
      theme.user_id = user_id
    end
    theme
  end

  def theme_name
    return '' if theme == DEFAULT_THEME
    theme
  end
end
