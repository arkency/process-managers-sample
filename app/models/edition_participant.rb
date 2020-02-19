class EditionParticipant < ApplicationRecord
  def self.handle_participant_event(event)
    edition_id     = event.data[:edition_id]
    participant_id = event.data[:participant_id]

    case event
    when Workshops::ParticipantPersonalDataProvided
      where(participant_id: participant_id).update_all(
        participant_name: event.data[:name],
        participant_email: event.data[:email]
      )
    when Workshops::ParticipantRegisteredForEdition
      find_or_create_by(edition_id: edition_id, participant_id: participant_id)
    end
  end
end
