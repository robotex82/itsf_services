module Itsf
  module Services
    class Engine < ::Rails::Engine
      isolate_namespace Itsf::Services
    end
  end
end
