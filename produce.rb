event_store = Rails.configuration.event_store
edition_id  = "smart-pension"
stream_name = "Edition$#{edition_id}"

EditionParticipant.delete_all
EditionStatus.delete_all

event_store.publish(
  Workshops::EditionConfirmed.new(data: { edition_id: edition_id }),
  stream_name: stream_name
)
event_store.publish(
  Workshops::ParticipantRegisteredForEdition.new(data: { edition_id: edition_id, participant_id: pid1 = SecureRandom.uuid }),
  stream_name: stream_name
)
event_store.publish(
  Workshops::ParticipantRegisteredForEdition.new(data: { edition_id: edition_id, participant_id: pid2 = SecureRandom.uuid }),
  stream_name: stream_name
)
event_store.publish(
  Workshops::ParticipantPersonalDataProvided.new(data: { participant_id: pid1, name: 'Tom', email: 't@acme' }),
  stream_name: stream_name
)
event_store.publish(
  Workshops::ParticipantPersonalDataProvided.new(data: { participant_id: pid2, name: 'Jerry', email: 'j@acme' }),
  stream_name: stream_name
)
