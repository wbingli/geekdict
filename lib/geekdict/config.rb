require "yaml"
require "fileutils"

module GeekDict
  module Config
    CONFIG_PATH = File.expand_path("~/.geekdict.config")
    DEFAULT_PROVIDER = "openrouter"
    DEFAULT_MODEL = "google/gemini-2.5-flash-lite"
    ALLOWED_PROVIDERS = ['openai', 'openrouter', 'youdao'].freeze

    module_function

    # Method to load configuration from ~/.geekdict.config
    def load_config
      config = {}

      # If config file doesn't exist, create it with default values
      unless File.exist?(CONFIG_PATH)
        create_default_config
      end

      if File.exist?(CONFIG_PATH)
        begin
          loaded_config = YAML.load_file(CONFIG_PATH)
          config = loaded_config if loaded_config.is_a?(Hash)
        rescue Psych::SyntaxError => e
          warn "Warning: Error parsing config file #{CONFIG_PATH}: #{e.message}. Using defaults."
        rescue => e
          warn "Warning: Could not load config file #{CONFIG_PATH}: #{e.message}. Using defaults."
        end
      end
      # Ensure keys are symbols for easier access, handle potential nil values
      config = config.transform_keys { |k| k.to_s.downcase.to_sym rescue k } # Make keys symbols & lowercase
      {
        provider: config[:provider],
        model: config[:model]
      }
    end

    # Method to create default configuration file
    def create_default_config
      default_config = {
        'provider' => DEFAULT_PROVIDER,
        'model' => DEFAULT_MODEL
      }

      begin
        # Ensure the directory exists
        config_dir = File.dirname(CONFIG_PATH)
        FileUtils.mkdir_p(config_dir) unless Dir.exist?(config_dir)

        # Write the default config
        File.open(CONFIG_PATH, 'w') do |file|
          file.write(YAML.dump(default_config))
        end

        puts "Created default config file at #{CONFIG_PATH}"
      rescue => e
        warn "Warning: Could not create config file #{CONFIG_PATH}: #{e.message}"
      end
    end
  end
end
