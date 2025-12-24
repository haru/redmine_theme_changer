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

module ThemeChangerApplicationHelperPatch
  # Override body_css_classes to include user-specific theme class
  def body_css_classes
    css_classes = super

    # Only modify theme class for logged-in users
    return css_classes unless User.current.logged?

    # Get user's theme setting
    setting = ThemeChangerUserSetting.find_theme_by_user_id(User.current.id)

    # If no setting or system setting is selected, use default behavior
    return css_classes unless setting
    return css_classes if setting.theme == ThemeChangerUserSetting::SYSTEM_SETTING

    # Remove existing theme class from the CSS classes
    css_classes = css_classes.gsub(/\btheme-\S+/, '').strip

    # Add new theme class at the beginning if a specific theme is set
    unless setting.theme.blank? || setting.theme == ThemeChangerUserSetting::DEFAULT_THEME
      theme = Redmine::Themes.theme(setting.theme)
      if theme
        css_classes = "theme-#{theme.name.tr(' ', '_')} #{css_classes}"
      end
    end

    # Clean up multiple spaces and return
    css_classes.gsub(/\s+/, ' ').strip
  end
end

ApplicationHelper.prepend(ThemeChangerApplicationHelperPatch)
