module ZeroDowntimeMigrations
  module Relation
    prepend Data

    def each(*, **, &block)
      Validation.validate!(:find_each)
      super
    end
  end
end
