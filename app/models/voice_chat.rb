class VoiceChat < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '可能' },
    { id: 3, name: '不可能' },
  ]

  include ActiveHash::Associations
  has_many :rules
  end