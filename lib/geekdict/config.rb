require "yaml"

module GeekDict
  module Config
    CONFIG_PATH = File.expand_path("~/.geekdict.config")
    DEFAULT_PROVIDER = "openrouter"
    DEFAULT_MODEL = "google/gemini-2.5-flash-preview"
    ALLOWED_PROVIDERS = ['openai', 'openrouter', 'youdao'].freeze

    module_function

    # Method to load configuration from ~/.geekdict.config
    def load_config
      config = {}
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
  end
end
