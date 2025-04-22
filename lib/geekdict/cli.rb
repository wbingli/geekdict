require "thor"
# Remove YAML require, handled in config.rb
require_relative 'local_history'
require_relative 'version'
require_relative 'config' # Add require for the new config module
require_relative 'openai/gpt.rb'
require_relative 'openrouter/api.rb'
# Assuming youdao might be added later or is handled elsewhere
# require_relative 'youdao/api.rb'
require_relative 'youdao/api.rb' # Keep youdao require

module GeekDict
  class CLI < Thor
    # Constants and load_config are now in GeekDict::Config

    desc "t", "Translate a word"
    option :debug, :aliases => '-d', :type => :boolean, :default => false
    option :open, :aliases => '-o', :type => :boolean, :default => false
    # Update enum and desc to use Config constants
    option :provider, :aliases => '-p', :type => :string, :enum => GeekDict::Config::ALLOWED_PROVIDERS, :desc => "Provider (overrides config: #{GeekDict::Config::ALLOWED_PROVIDERS.join('/')})"
    # Add model option
    option :model, :aliases => '-m', :type => :string, :desc => "LLM model (overrides config)"
    def t(word)
      GeekDict.debugger options[:debug]
      LocalHistory.save word

      # 1. Load config file using the Config module
      config = GeekDict::Config.load_config

      # 2. Determine provider: CLI option > Config file > Default (use Config constants)
      provider = options[:provider]&.downcase || config[:provider] || GeekDict::Config::DEFAULT_PROVIDER

      # 3. Determine model: CLI option > Config file > Default (use Config constants)
      model = options[:model] || config[:model] || GeekDict::Config::DEFAULT_MODEL

      # 4. Validate provider (use Config constants)
      unless GeekDict::Config::ALLOWED_PROVIDERS.include?(provider)
        warn "Warning: Invalid provider '#{provider}' specified. Using default '#{GeekDict::Config::DEFAULT_PROVIDER}'."
        provider = GeekDict::Config::DEFAULT_PROVIDER
        # Reset model if provider changed to default, unless model was explicitly set via CLI
        model = options[:model] || GeekDict::Config::DEFAULT_MODEL # Use default model for the default provider
      end

      # Optional: Output effective settings for debugging/clarity
      puts "Using provider: #{provider}, model: #{model}" if options[:debug]

      # 5. Call the appropriate provider with the word and model
      result = case provider
               when 'openai'
                 # TODO: Update OpenAI class to accept model
                 GeekDict::OpenAI.translate(word, model: model)
               when 'openrouter'
                 # TODO: Update OpenRouter class to accept model
                 GeekDict::OpenRouter.translate(word, model: model)
               when 'youdao'
                 # Youdao might not use a 'model' in the same way.
                 # If it needs config, adjust here. For now, pass nothing extra.
                 GeekDict::Youdao.translate(word)
               else
                 # This case should technically not be reached due to validation
                 warn "Internal Error: Unknown provider '#{provider}'. Aborting."
                 exit 1
               end

      puts result
    end

        desc "v", "version"
        def v()
          puts GeekDict::VERSION
        end

    end
end
