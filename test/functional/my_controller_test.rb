# Theme Changer plugin for Redmine
# Copyright (C) 2017  Haruyuki Iida
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

class MyControllerTest < Redmine::ControllerTest
  fixtures :users, :email_addresses, :user_preferences, :roles, :projects, :members, :member_roles,
    :issues, :issue_statuses, :trackers, :enumerations, :custom_fields, :auth_sources, :queries

  def setup
    @request.session[:user_id] = 2
  end

  def test_my_account
    get :account
    assert_response :success
    assert_select 'select[name=?]', 'pref[theme]'
  end

  def test_update_account
    post :account, params: {
        user: {
          firstname: "Joe",
          login: "root",
          admin: 1,
          group_ids: ['10'],
        },
        pref: {
          theme: 'alternate'
        }
      }

    assert_redirected_to '/my/account'
    user = User.find(2)
    assert_equal "Joe", user.firstname
    assert_equal 'alternate', user.preference.theme
  end
end