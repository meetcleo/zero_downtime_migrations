module ZeroDowntimeMigrations
  class Validation
    def self.validate!(type, *args, **kwargs)
      return unless Migration.migrating? && Migration.unsafe?

      begin
        validator = type.to_s.classify
        const_get(validator).new(Migration.current, *args, **kwargs).validate!
      rescue NameError
        raise UndefinedValidationError.new(validator)
      end
    end

    attr_reader :migration, :args, :kwargs

    def initialize(migration, *args, **kwargs)
      @migration = migration
      @args = args
      @kwargs = kwargs || {}
    end

    def error!(message)
      error = UnsafeMigrationError
      debug = "#{error}: #{migration_name} is unsafe!"
      message = [message, debug, nil].join("\n")
      raise error.new(message)
    end

    def migration_name
      migration.class.name
    end

    def options
      kwargs
    end

    def validate!
      raise NotImplementedError
    end
  end
end
