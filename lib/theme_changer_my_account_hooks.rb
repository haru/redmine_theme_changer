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

class ThemeChangerMyAccountHooks < Redmine::Hook::ViewListener

  include ApplicationHelper
  
  def view_my_account(context = {})
    user = context[:user]
    f = context[:form]
    return '' unless user
    o = ''
    o << '<hr/><p>'
    o << f.select(:theme, [['System Setting',ThemeChangerUserSetting::SYSTEM_SETTING], 
        [l(:label_default),ThemeChangerUserSetting::DEFAULT_THEME]] + Redmine::Themes.themes.collect {|t| [t.name, t.id]} ,
      :label => :label_theme)
    o << '</p>'
    return o

  end

  
end
