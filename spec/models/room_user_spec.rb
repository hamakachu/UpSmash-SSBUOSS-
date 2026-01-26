require 'rails_helper'

RSpec.describe RoomUser, type: :model do
  describe 'バリデーション' do
    let(:room) { create(:room) }
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }

    context 'user_idのユニーク制約' do
      it '同じルームに同じユーザーを2回追加できない' do
        create(:room_user, room: room, user: user1)
        duplicate_room_user = build(:room_user, room: room, user: user1)

        expect(duplicate_room_user).not_to be_valid
        expect(duplicate_room_user.errors[:user_id]).to include('は既にこのルームに参加しています')
      end

      it '異なるルームには同じユーザーを追加できる' do
        another_room = create(:room)
        create(:room_user, room: room, user: user1)
        another_room_user = build(:room_user, room: another_room, user: user1)

        expect(another_room_user).to be_valid
      end
    end

    context '定員チェック' do
      it 'ルームに2人まで参加できる' do
        create(:room_user, room: room, user: user1)
        room_user2 = build(:room_user, room: room, user: user2)

        expect(room_user2).to be_valid
      end

      it 'ルームに3人目は参加できない' do
        create(:room_user, room: room, user: user1)
        create(:room_user, room: room, user: user2)
        room_user3 = build(:room_user, room: room, user: user3)

        expect(room_user3).not_to be_valid
        expect(room_user3.errors[:base]).to include('このルームはすでに定員に達しています')
      end
    end
  end

  describe 'アソシエーション' do
    it { should belong_to(:user) }
    it { should belong_to(:room) }
  end
end
