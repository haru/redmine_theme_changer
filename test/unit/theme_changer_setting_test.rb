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
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class ThemeChangerSettingTest < ActiveSupport::TestCase
  fixtures :theme_changer_user_settings, :users

  def setup
    User.current = User.second
  end

  def test_setting_ui_theme_returns_custom_user_theme_if_set
    assert_equal('alternate', Setting.ui_theme)
  end
end
