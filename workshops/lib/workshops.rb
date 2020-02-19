module Workshops
  ParticipantRegisteredForEdition = Class.new(RailsEventStore::Event)
  VenueBookedForEdition           = Class.new(RailsEventStore::Event)
  TwoWeeksBeforeEditionReached    = Class.new(RailsEventStore::Event)
  ParticipantPersonalDataProvided = Class.new(RailsEventStore::Event)
  EditionConfirmed                = Class.new(RailsEventStore::Event)

  ConfirmEdition = Struct.new(:edition_id)
  CancelEdition  = Struct.new(:edition_id)
end

require_dependency 'workshops/cancellation_policy'
