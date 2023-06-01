class Format < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'スマメイトルール' },
    { id: 3, name: '篝火ルール' },
    { id: 4, name: 'チャットで相談' },
  ]

  include ActiveHash::Associations
  has_many :rules
  end