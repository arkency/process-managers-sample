class EditionsController < ApplicationController
  def show
    edition_id = params[:id]

    render :show, locals: {
      edition_id: edition_id,
      participants: EditionParticipant.where(edition_id: edition_id),
      edition_status: EditionStatus.find_by(edition_id: edition_id)
    }
  end
end
