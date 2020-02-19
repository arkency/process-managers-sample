class EditionStatus < ApplicationRecord
  def self.handle_confirmed_event(e)
    edition_id = e.data[:edition_id]
    find_or_create_by(edition_id: edition_id).update(status: "confirmed")
  end
end
