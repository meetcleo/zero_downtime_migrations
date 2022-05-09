module ZeroDowntimeMigrations
  module Data
    def initialize(*, **, &block)
      Migration.data = true
      super
    end
  end
end
