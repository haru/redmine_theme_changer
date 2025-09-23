# Redmine Theme Changer Plugin - AI Agent Instructions

## Project Overview
This is a Redmine plugin that enables individual users to select their preferred theme from their account settings. The plugin follows Redmine's plugin architecture using Ruby on Rails conventions with specific Redmine extensions.

## Architecture & Key Components

### Plugin Entry Point
- **`init.rb`**: Main plugin registration file that defines metadata, dependencies, and requires all necessary modules
- Registers as `redmine_theme_changer` plugin with version requirement `>= 5.0.0`
- Loads three core modules: hooks, user preference patches, and themes patches

### Core Architecture Pattern: Ruby Module Patches
This plugin extends Redmine core functionality through Ruby module patches (not inheritance):

```ruby
# Pattern: Extend existing Redmine classes
module ThemeChangerUserPreferencePatch
  # Add methods to existing class
end
UserPreference.prepend(ThemeChangerUserPreferencePatch)
```

### Key Components

1. **Model Layer** (`app/models/theme_changer_user_setting.rb`)
   - Custom ActiveRecord model storing per-user theme preferences
   - Constants: `DEFAULT_THEME`, `SYSTEM_SETTING` for special theme states
   - Class methods: `find_theme_by_user_id`, `find_or_create_theme_by_user_id`

2. **Hook Integration** (`lib/theme_changer_my_account_hooks.rb`)
   - Uses Redmine's `ViewListener` hook system to inject UI
   - Renders partial `my/theme_changer_form` in user account settings

3. **Core Patches** (`lib/` directory)
   - **UserPreferencePatch**: Adds `theme` getter/setter to UserPreference model
   - **ThemesPatch**: Overrides ApplicationHelper's theme resolution logic
   - Uses `prepend` pattern for safe monkey-patching

### Database Schema
- Single table: `theme_changer_user_settings`
- Fields: `user_id` (integer), `theme` (string), `updated_at` (timestamp)
- Migration file: `db/migrate/0001_create_theme_changer_user_settings.rb`

## Development Workflows

### Testing Strategy
```bash
# Run plugin tests within Redmine context
bundle exec rake redmine:plugins:test NAME=redmine_theme_changer
```

- **Test Structure**: Standard Rails testing with Redmine fixtures
- **Coverage**: Uses SimpleCov with multiple formatters (HTML, LCOV, RCov)
- **CI**: GitHub Actions with matrix testing across Ruby versions (3.0-3.4) and Redmine versions (5.0-6.1)

### Build Scripts (`build-scripts/`)
- **`install.sh`**: Sets up test environment, clones Redmine, installs dependencies
- **`build.sh`**: Runs plugin tests within Redmine context
- **`env.sh`**: Environment configuration for CI/local development

### Plugin Installation
```bash
# Standard Redmine plugin installation
rake redmine:plugins:migrate RAILS_ENV=production
```

## Project-Specific Conventions

### File Organization
- Plugin follows Redmine conventions: `app/`, `lib/`, `config/`, `db/migrate/`
- Patches stored in `lib/` with descriptive names ending in `_patch.rb`
- Views use Redmine's partial injection pattern in `app/views/my/`

### Naming Conventions
- All classes/modules prefixed with `ThemeChanger`
- Database table: `theme_changer_user_settings` (plugin_name + model_plural)
- Constants use SCREAMING_SNAKE_CASE for special theme identifiers

### Code Documentation
- **Source code comments must be written in English only**

### Internationalization
- Locale files in `config/locales/` following Rails i18n
- Supports 12 languages with community contributions
- Key pattern: `label_` prefix for UI labels

### Integration Points

#### Redmine Core Integration
- **Hooks**: `view_my_account` hook injects theme selector form
- **Patches**: Safely extends `UserPreference` and `ApplicationHelper`
- **Theme Resolution**: Overrides Redmine's default theme logic in `ApplicationHelper`

#### Theme System Integration
```ruby
# Theme resolution priority:
# 1. User's saved theme (if not SYSTEM_SETTING)
# 2. System default (Setting.ui_theme)
# 3. Fallback handling for invalid themes
```

## Testing Patterns
- Use Redmine test fixtures (users, theme_changer_user_settings)
- Test both model logic and integration with Redmine core
- Verify patch behavior doesn't break existing functionality

## Git Conventions
- **Commit messages must be written in English only**
- Use conventional commit format when possible
- Keep commit messages concise and descriptive

## License & Copyright
- GPL v2+ license with extensive copyright headers in all files
- Maintained by Haruyuki Iida since 2010
- Community contributions welcomed for translations