class MatchCount < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '2本先取' },
    { id: 3, name: '3本先取' },
    { id: 4, name: '5本先取' },
    { id: 5, name: '10本先取' },
    { id: 6, name: '飽き抜け' },
  ]

  include ActiveHash::Associations
  has_many :rules
  end