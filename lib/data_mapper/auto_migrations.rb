require __DIR__ + 'migrator'

module DataMapper
  module AutoMigrations
    def self.included(model)
      DataMapper::AutoMigrator.models << model
    end
  end
  
  class AutoMigrator
    
    def self.models
      @@models ||= []
    end
    
    def self.auto_migrate(repository)
      models.each do |model|
        repository.adapter.destroy_store(repository, model)
        repository.adapter.create_store(repository, model)
      end
    end
  end
end # module DataMapper
