# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( welcome.css search.css )
Rails.application.config.assets.precompile += %w( auth.css )
Rails.application.config.assets.precompile += %w( posts.css )
Rails.application.config.assets.precompile += %w( newpost.css )
Rails.application.config.assets.precompile += %w( animations.css )
Rails.application.config.assets.precompile += %w( icon-font.css )
Rails.application.config.assets.precompile += %w( template25.css )
Rails.application.config.assets.precompile += %w( medium-editor-insert-plugin.css )
