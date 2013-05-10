module Translator
  class Engine < Rails::Engine
    isolate_namespace Translator
    config.autoload_paths += %W(#{config.root}/lib #{config.root}/config )
  end
end
