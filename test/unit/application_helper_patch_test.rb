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
  fixtures :theme_changer_user_settings, :users

  def setup
    User.current = nil
    @project = nil
    stubs(:display_main_menu?).returns(false)
    stubs(:controller_name).returns('test')
    stubs(:action_name).returns('index')
  end

  def test_body_css_classes_with_user_theme
    User.current = User.find(1)
    css_classes = body_css_classes
    assert_match(/\Atheme-Classic/, css_classes)
  end

  def test_body_css_classes_with_alternate_theme
    User.current = User.find(2)
    css_classes = body_css_classes
    assert_match(/\Atheme-Alternate/, css_classes)
  end

  def test_body_css_classes_when_not_logged_in
    User.current = User.anonymous
    with_settings :ui_theme => 'classic' do
      css_classes = body_css_classes
      assert_match(/\Atheme-/, css_classes)
    end
  end
end
