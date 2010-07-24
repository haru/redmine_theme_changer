# Theme Changer plugin for Redmine
# Copyright (C) 2010  Haruyuki Iida
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
require_dependency 'User'

class User < Principal
  has_one :theme_setting, :dependent => :destroy, :class_name => 'ThemeChangerUserSetting'

  def theme
    return nil unless self.theme_setting
    self.theme_setting.theme
  end

  def theme=(name)
    self.theme_setting = ThemeChangerUserSetting.new unless self.theme_setting
    self.theme_setting.theme = name
    self.theme_setting.save!
  end
end
