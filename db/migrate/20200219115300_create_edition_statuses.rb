class CreateEditionStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :edition_statuses do |t|
      t.string :edition_id
      t.string :status

      t.timestamps
    end
  end
end
