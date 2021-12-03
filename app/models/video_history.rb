class VideoHistory < ApplicationRecord
  belongs_to :video
  belongs_to :user

  validates :video, uniqueness: { message: 'Vídeo já foi marcado como assitido', scope: :user }

  validates :user, uniqueness: { message: 'Vídeo já foi marcado como assitido', scope: :video }
end
