# Theme Changer plugin for Redmine
# Copyright (C) 2010-2025  Haruyuki Iida
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

class ApplicationHelperPatchTest < ActiveSupport::TestCase
  include ApplicationHelper
  include Redmine::I18n
  fixtures :users

  def setup
    User.current = nil
    cleanup_test_data

    # Stub helper methods that are called by body_css_classes
    @project = nil
    stubs(:display_main_menu?).returns(false)
    stubs(:controller_name).returns('test')
    stubs(:action_name).returns('index')
  end

  def teardown
    cleanup_test_data
  end

  def test_body_css_classes_without_user_setting
    # User 3 has no theme setting, should use system default
    User.current = User.find(3)

    # Mock Setting.ui_theme (Redmine theme IDs are lowercase)
    with_settings :ui_theme => 'classic' do
      css_classes = body_css_classes
      assert_match(/\Atheme-Classic/, css_classes, "Should include system theme class at the beginning")
    end
  end

  def test_body_css_classes_with_system_setting
    # Create a user with SYSTEM_SETTING
    User.current = User.find(3)
    setting = ThemeChangerUserSetting.create!(
      user_id: 3,
      theme: ThemeChangerUserSetting::SYSTEM_SETTING
    )

    with_settings :ui_theme => 'classic' do
      css_classes = body_css_classes
      assert_match(/\Atheme-Classic/, css_classes, "Should include system theme class at the beginning when SYSTEM_SETTING is selected")
    end

    setting.destroy
  end

  def test_body_css_classes_with_default_theme
    # Create a user with DEFAULT_THEME
    User.current = User.find(3)
    setting = ThemeChangerUserSetting.create!(
      user_id: 3,
      theme: ThemeChangerUserSetting::DEFAULT_THEME
    )

    css_classes = body_css_classes
    assert_no_match(/theme-/, css_classes, "Should not include any theme class when DEFAULT_THEME is selected")

    setting.destroy
  end

  def test_body_css_classes_with_specific_theme
    # Create a user with 'classic' theme (theme ID is lowercase, but name is Classic)
    User.current = User.find(1)
    setting = ThemeChangerUserSetting.create!(
      user_id: 1,
      theme: 'classic'
    )

    css_classes = body_css_classes
    assert_match(/\Atheme-Classic/, css_classes, "Should include user's selected theme class at the beginning")

    setting.destroy
  end

  def test_body_css_classes_replaces_theme_class
    # Create a user with 'alternate' theme
    User.current = User.find(2)
    setting = ThemeChangerUserSetting.create!(
      user_id: 2,
      theme: 'alternate'
    )

    # Set system theme to something different
    with_settings :ui_theme => 'classic' do
      css_classes = body_css_classes

      # Should have the user's theme at the beginning, not the system theme
      assert_match(/\Atheme-Alternate/, css_classes, "Should include user's theme class at the beginning")
      assert_no_match(/theme-Classic/, css_classes, "Should not include system theme class")
    end

    setting.destroy
  end

  def test_body_css_classes_when_not_logged_in
    # Anonymous user should use system default
    User.current = User.anonymous

    with_settings :ui_theme => 'classic' do
      css_classes = body_css_classes
      assert_match(/\Atheme-Classic/, css_classes, "Should include system theme at the beginning for anonymous user")
    end
  end

  def test_body_css_classes_preserves_other_classes
    # Ensure other CSS classes are not affected
    User.current = User.find(1)

    css_classes = body_css_classes

    # Check that basic structure is maintained
    assert css_classes.is_a?(String), "Should return a string"
    assert_no_match(/\s{2,}/, css_classes, "Should not have multiple consecutive spaces")
  end

  def test_body_css_classes_with_nonexistent_theme
    # Test that nonexistent theme doesn't break the code
    User.current = User.find(3)

    # Create a setting with a nonexistent theme
    setting = ThemeChangerUserSetting.create!(
      user_id: 3,
      theme: 'nonexistent'
    )

    # Should not raise an error
    assert_nothing_raised do
      css_classes = body_css_classes
      # Should not have the nonexistent theme class since theme doesn't exist
      assert_no_match(/theme-nonexistent/, css_classes)
    end

    setting.destroy
  end

  private

  def cleanup_test_data
    # Clean up any test settings created during tests
    ThemeChangerUserSetting.where("user_id >= 1 AND user_id <= 10").delete_all
  end
end
