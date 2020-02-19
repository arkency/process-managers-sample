require_relative 'test_helper'

module Workshops
  class CancellationPolicyTest < ActiveSupport::TestCase
    test "when minimum participant limit is reached and venue is booked workshop is confirmed" do
      command_bus         = FakeCommandBus.new
      cancellation_policy = CancellationPolicy.new(command_bus)

      [ participant_registered_for_edition(edition_id),
        participant_registered_for_edition(edition_id),
        participant_registered_for_edition(edition_id),
        participant_registered_for_edition(edition_id),
        participant_registered_for_edition(edition_id),
        participant_registered_for_edition(edition_id),
        participant_registered_for_edition(edition_id),
        participant_registered_for_edition(edition_id),
        participant_registered_for_edition(edition_id),
        venue_booked_for_edition(edition_id),
        participant_registered_for_edition(edition_id),
      ].each do |event|
        cancellation_policy.call(event)
      end

      assert_command command_bus, ConfirmEdition.new(edition_id)
    end

    test "when minimum participant limit is not reached up to 2 weeks before date workshop is cancelled" do
      command_bus         = FakeCommandBus.new
      cancellation_policy = CancellationPolicy.new(command_bus)

      [ participant_registered_for_edition(edition_id),
        participant_registered_for_edition(edition_id),
        participant_registered_for_edition(edition_id),
        participant_registered_for_edition(edition_id),
        participant_registered_for_edition(edition_id),
        two_weeks_before_start_date_reached(edition_id),
      ].each do |event|
        cancellation_policy.call(event)
      end

      assert_command command_bus, CancelEdition.new(edition_id)
    end

    private

    def assert_command(command_bus, command)
      assert_includes command_bus.commands, command
    end

    def edition_id
      "1bdd51e1-216f-446a-a401-b729d0519282"
    end

    def participant_registered_for_edition(edition_id)
      ParticipantRegisteredForEdition.new(data: {
        edition_id: edition_id,
        participant_id: SecureRandom.uuid
      })
    end

    def two_weeks_before_start_date_reached(edition_id)
      TwoWeeksBeforeEditionReached.new(data: {
        edition_id: edition_id
      })
    end

    def venue_booked_for_edition(edition_id)
      VenueBookedForEdition.new(data: {
        edition_id: edition_id
      })
    end
  end
end
