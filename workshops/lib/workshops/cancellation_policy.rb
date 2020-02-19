module Workshops
  class CancellationPolicy
    def initialize(command_bus)
      @command_bus = command_bus
    end

    def call(event)
      # @command_bus.call(CancelEdition.new(edition_id))
      # @command_bus.call(ConfirmEdition.new(edition_id))
    end
  end
end

