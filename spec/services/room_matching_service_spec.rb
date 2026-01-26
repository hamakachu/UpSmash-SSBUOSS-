require 'rails_helper'

RSpec.describe RoomMatchingService, type: :service do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  describe '.create_room' do
    let(:valid_params) do
      {
        room_name: 'テストルーム',
        host_user_id: user.id
      }
    end

    context '有効なパラメータの場合' do
      it 'ルームが作成される' do
        expect {
          RoomMatchingService.create_room(valid_params, user)
        }.to change(Room, :count).by(1)
      end

      it 'ホストユーザーが自動的にルームに追加される' do
        result = RoomMatchingService.create_room(valid_params, user)
        expect(result.room.users).to include(user)
      end

      it '成功のResultオブジェクトを返す' do
        result = RoomMatchingService.create_room(valid_params, user)
        expect(result.success?).to be true
        expect(result.room).to be_a(Room)
        expect(result.error_message).to be_nil
      end
    end

    context '無効なパラメータの場合' do
      let(:invalid_params) do
        {
          room_name: nil,
          host_user_id: user.id
        }
      end

      it 'ルームが作成されない' do
        expect {
          RoomMatchingService.create_room(invalid_params, user)
        }.not_to change(Room, :count)
      end

      it '失敗のResultオブジェクトを返す' do
        result = RoomMatchingService.create_room(invalid_params, user)
        expect(result.success?).to be false
        expect(result.room).to be_nil
        expect(result.error_message).to be_present
      end
    end
  end

  describe '.join_room' do
    let(:room) { create(:room) }
    let!(:host_room_user) { create(:room_user, room: room, user: room.host_user) }

    context '有効な参加の場合' do
      it 'ユーザーがルームに参加できる' do
        expect {
          RoomMatchingService.join_room(room.id, user)
        }.to change(RoomUser, :count).by(1)
      end

      it '成功のResultオブジェクトを返す' do
        result = RoomMatchingService.join_room(room.id, user)
        expect(result.success?).to be true
        expect(result.room).to eq(room)
        expect(result.error_message).to be_nil
      end
    end

    context '既に参加済みの場合' do
      before { create(:room_user, room: room, user: user) }

      it 'ルームに参加できない' do
        expect {
          RoomMatchingService.join_room(room.id, user)
        }.not_to change(RoomUser, :count)
      end

      it '失敗のResultオブジェクトを返す' do
        result = RoomMatchingService.join_room(room.id, user)
        expect(result.success?).to be false
        expect(result.error_message).to eq('既にこのルームに参加しています')
      end
    end

    context 'ルームが定員に達している場合' do
      before do
        create(:room_user, room: room, user: user)
      end

      it 'ルームに参加できない' do
        user3 = create(:user)
        expect {
          RoomMatchingService.join_room(room.id, user3)
        }.not_to change(RoomUser, :count)
      end

      it '失敗のResultオブジェクトを返す' do
        user3 = create(:user)
        result = RoomMatchingService.join_room(room.id, user3)
        expect(result.success?).to be false
        expect(result.error_message).to eq('このルームはすでに定員に達しています')
      end
    end

    context 'ルームが見つからない場合' do
      it '失敗のResultオブジェクトを返す' do
        result = RoomMatchingService.join_room(99999, user)
        expect(result.success?).to be false
        expect(result.error_message).to eq('ルームが見つかりません')
      end
    end
  end

  describe 'Result' do
    describe '#success?' do
      it '成功の場合trueを返す' do
        result = RoomMatchingService::Result.new(success: true)
        expect(result.success?).to be true
      end

      it '失敗の場合falseを返す' do
        result = RoomMatchingService::Result.new(success: false)
        expect(result.success?).to be false
      end
    end
  end
end
