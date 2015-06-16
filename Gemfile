source "https://rubygems.org"

# Declare your gem's dependencies in bob.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.


gem 'pg'

group :development, :test do
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug' unless Gem.win_platform?
  gem 'pry-stack_explorer'

  gem 'awesome_print'                # Better console printing

  gem 'faker'

  # To use debugger
  #gem 'debugger'
end