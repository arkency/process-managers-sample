class CreateEditionParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :edition_participants do |t|
      t.string :edition_id
      t.string :participant_id
      t.string :participant_name
      t.string :participant_email

      t.timestamps
    end
  end
end
