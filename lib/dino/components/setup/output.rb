module Dino
  module Components
    module Setup
      module Output
        protected

        def initialize_pins(options={})
          super(options)
          self.mode = :out
        end
      end
    end
  end
end
