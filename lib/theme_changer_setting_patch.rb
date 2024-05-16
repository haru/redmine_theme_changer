module ThemeChangerSetting #:nodoc: all
  def self.prepended(base)
    base.singleton_class.prepend ClassMethods
  end

  module ClassMethods
    def ui_theme
      setting = ThemeChangerUserSetting.find_theme_by_user_id(User.current.id)
      return self[:ui_theme] unless setting
      if setting.theme == ThemeChangerUserSetting::SYSTEM_SETTING
        return self[:ui_theme]
      end

      setting.theme_name
    end
  end
end

Setting.prepend(ThemeChangerSetting) unless Setting.include? ThemeChangerSetting
