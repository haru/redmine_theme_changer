[![build](https://github.com/haru/redmine_theme_changer/actions/workflows/build.yml/badge.svg)](https://github.com/haru/redmine_theme_changer/actions/workflows/build.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/dfb7a19b63de2a367cc8/maintainability)](https://codeclimate.com/github/haru/redmine_theme_changer/maintainability)
[![codecov](https://codecov.io/gh/haru/redmine_theme_changer/branch/develop/graph/badge.svg?token=CFSALMKJJY)](https://codecov.io/gh/haru/redmine_theme_changer)
[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/haru/redmine_theme_changer)
![Redmine](https://img.shields.io/badge/redmine->=5.0-blue?logo=redmine&logoColor=%23B32024&labelColor=f0f0f0&link=https%3A%2F%2Fwww.redmine.org)

# Redmine Theme Changer Plugin

This is a plugin for Redmine that enables individual users to select their preferred theme from their account settings. Users can override the system default theme with their personal preference.

🌐 **Plugin Homepage**: https://www.redmine.org/plugins/redmine_theme_changer

## Features

- ✨ Individual theme selection per user
- 🔧 System-wide theme fallback support

## Requirements

- Redmine >= 5.0.0
- Ruby >= 3.0
- Rails compatible with your Redmine version

## Installation

### From Source

1. Navigate to your Redmine plugins directory:
   ```bash
   cd /path/to/redmine/plugins
   ```

2. Clone or copy the plugin:
   ```bash
   git clone https://github.com/haru/redmine_theme_changer.git
   ```

3. Install dependencies and migrate the plugin:
   ```bash
   cd /path/to/redmine
   bundle install
   rake redmine:plugins:migrate RAILS_ENV=production
   ```

4. Restart your Redmine instance.

### From ZIP

1. Download the latest release from the [GitHub releases page](https://github.com/haru/redmine_theme_changer/releases)
2. Extract to your Redmine `plugins/` directory
3. Follow steps 3-4 from the source installation

## Usage

After installation:

1. Log in to your Redmine instance
2. Go to **My Account** (top-right menu)
3. Find the **Theme** section in your account settings
4. Select your preferred theme from the dropdown
5. Save your settings

The theme change will be applied immediately across all your Redmine sessions.

## Uninstallation

To remove the plugin:

1. Rollback the plugin migration:
   ```bash
   rake redmine:plugins:migrate NAME=redmine_theme_changer RAILS_ENV=production VERSION=0
   ```

2. Remove the plugin directory:
   ```bash
   rm -rf plugins/redmine_theme_changer
   ```

3. Restart Redmine.

## Development

### Running Tests

```bash
# Install test dependencies
bundle install

# Run plugin tests
bundle exec rake redmine:plugins:test NAME=redmine_theme_changer
```

### Project Structure

```
redmine_theme_changer/
├── app/
│   ├── models/           # ThemeChangerUserSetting model
│   └── views/           # Theme selection form partial
├── config/locales/      # Internationalization files
├── db/migrate/          # Database migrations
├── lib/                 # Core plugin logic and patches
└── test/               # Test files and fixtures
```

### Architecture

This plugin extends Redmine core functionality through Ruby module patches:
- **UserPreferencePatch**: Adds theme getter/setter to UserPreference model  
- **ThemesPatch**: Overrides ApplicationHelper's theme resolution logic
- **MyAccountHooks**: Injects theme selector into user account settings

## Contributing

Contributions are welcome! Please feel free to submit pull requests, report bugs, or suggest features.

### How to Contribute

1. **Fork the repository** on GitHub
2. **Create a feature branch** from the `develop` branch:
   ```bash
   git checkout develop
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes** and test them
4. **Commit your changes** with descriptive commit messages
5. **Push to your fork** and create a pull request

**Important**: All pull requests must be submitted against the `develop` branch, not `main`. Pull requests against other branches will be closed.

### Adding New Translations

To add a new language:
1. Copy `config/locales/en.yml` to `config/locales/[your_language].yml`
2. Translate the strings while keeping the keys unchanged
3. Submit a pull request against the `develop` branch

## License

This plugin is released under the GNU General Public License v2 or later.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history and changes.

## Support

- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/haru/redmine_theme_changer/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/haru/redmine_theme_changer/discussions)  
- 📧 **Email**: Contact via GitHub

## Author

**Haruyuki Iida** - *Initial work and maintenance*

---

⭐ If this plugin helps you, please consider giving it a star on GitHub!

