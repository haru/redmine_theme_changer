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

class ThemeChangerUserSettingTest < ActiveSupport::TestCase
  fixtures :theme_changer_user_settings, :users

  def test_find_theme_by_user_id
    setting = ThemeChangerUserSetting.find_theme_by_user_id 1
    assert_equal(1, setting.user.id)
    assert_equal('classic', setting.theme)
  end

  def test_find_or_create_theme_by_user_id
    setting = ThemeChangerUserSetting.find_or_create_theme_by_user_id 1
    assert_equal(1, setting.user.id)
    assert_equal('classic', setting.theme)

    setting = ThemeChangerUserSetting.find_or_create_theme_by_user_id 3
    assert_equal(3, setting.user.id)
    assert_nil(setting.theme)
  end

  def test_theme_name
    setting = ThemeChangerUserSetting.new
    assert_nil(setting.theme_name)
    setting.theme = 'foo'
    assert_equal('foo', setting.theme_name)
    setting.theme = ThemeChangerUserSetting::DEFAULT_THEME
    assert_equal('', setting.theme_name)
  end
end
