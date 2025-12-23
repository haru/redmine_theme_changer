# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Redmine plugin that allows individual users to select their preferred theme from account settings. The plugin extends Redmine core functionality through Ruby module patches rather than inheritance.

**Requirements**: Redmine >= 5.0.0, Ruby >= 3.0

## Development Commands

### Running Tests
```bash
# Run all plugin tests (must be executed from Redmine root directory)
bundle exec rake redmine:plugins:test NAME=redmine_theme_changer
```

### Plugin Installation/Migration
```bash
# Install plugin (run from Redmine root)
rake redmine:plugins:migrate RAILS_ENV=production

# Rollback plugin
rake redmine:plugins:migrate NAME=redmine_theme_changer VERSION=0 RAILS_ENV=production
```

### CI Build Scripts
The plugin uses build scripts in `build-scripts/` for CI testing:
- `install.sh`: Clones Redmine, installs dependencies, runs migrations
- `build.sh`: Executes plugin tests
- `env.sh`: Environment configuration

Tests run in a matrix across Ruby 3.0-3.4 and Redmine 5.0-6.1 with SQLite/MySQL/PostgreSQL.

## Architecture

### Core Pattern: Module Prepending for Redmine Core Extension

The plugin uses Ruby's `prepend` pattern to safely extend Redmine classes without inheritance:

```ruby
module ThemeChangerUserPreferencePatch
  # Override/extend methods
end
UserPreference.prepend(ThemeChangerUserPreferencePatch)
```

### Three-Component Architecture

1. **Model Layer** (`app/models/theme_changer_user_setting.rb`)
   - ActiveRecord model storing per-user theme preferences
   - Special constants: `SYSTEM_SETTING` (use system default), `DEFAULT_THEME` (empty theme)
   - Class methods: `find_theme_by_user_id`, `find_or_create_theme_by_user_id`

2. **Patch Layer** (`lib/`)
   - **UserPreferencePatch**: Adds `theme` getter/setter to UserPreference model, marks as safe_attribute
   - **ThemesPatch**: Overrides `ApplicationHelper#current_theme` and `get_theme` for theme resolution
   - **MyAccountHooks**: Redmine ViewListener hook that injects theme selector form into account settings

3. **View Layer** (`app/views/my/_theme_changer_form.html.erb`)
   - Partial injected via hook into user account page
   - Dropdown with: System Setting, Default Theme, plus all installed themes

### Theme Resolution Logic

Theme selection priority (implemented in `ThemeChangerThemesPatch`):
1. Check user's saved theme in `theme_changer_user_settings` table
2. If `SYSTEM_SETTING`, fall back to `Setting.ui_theme` (Redmine system default)
3. If `DEFAULT_THEME`, return empty string (Redmine's built-in default)
4. Otherwise return user's selected theme

### Database Schema

Single table: `theme_changer_user_settings`
- `user_id` (integer, references users)
- `theme` (string, stores theme ID or special constants)
- `updated_at` (timestamp)

### Hook Integration Point

Uses Redmine's hook system: `view_my_account` hook renders the theme selector form in user account settings.

## Project Conventions

### Language Requirements
- **All source code comments must be in English**
- **All commit messages must be in English**

### Naming Conventions
- Classes/modules prefixed with `ThemeChanger`
- Database tables: `theme_changer_*` (plugin name prefix)
- Patch files end with `_patch.rb`

### Testing
- Test helper configures SimpleCov with multiple formatters (HTML, LCOV, RCov)
- Tests use Redmine's test fixtures loaded from `test/fixtures/`
- Plugin tests run within parent Redmine context (via `test/test_helper.rb` line 23)

### Internationalization
- Locale files in `config/locales/*.yml`
- Supports 12 languages (en, ja, de, fr, ru, zh, ko, pl, pt-BR, bg, cs, tr)
- Key naming: `label_*` prefix for UI labels

### File Organization
```
redmine_theme_changer/
├── init.rb                 # Plugin registration, requires all modules
├── app/
│   ├── models/            # ThemeChangerUserSetting model
│   └── views/my/          # Theme selector form partial
├── lib/                   # Core patches (hooks, preference, themes)
├── config/locales/        # i18n translations
├── db/migrate/            # Database migrations
├── test/                  # Tests and fixtures
└── build-scripts/         # CI installation and test scripts
```

## Git Workflow

- Main development branch: `develop`
- Pull requests must target `develop`, not `main`
- PRs against other branches will be closed

## License

GPL v2+ with copyright headers required in all files. Maintained by Haruyuki Iida since 2010.
