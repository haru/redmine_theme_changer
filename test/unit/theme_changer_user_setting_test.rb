require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class ThemeChangerUserSettingTest < ActiveSupport::TestCase
  fixtures :theme_changer_user_settings, :users

  def test_find_theme_by_user_id
    setting = ThemeChangerUserSetting.find_theme_by_user_id 1
    assert_equal(1, setting.user.id)
    assert_equal('classic', setting.theme)
  end
end
