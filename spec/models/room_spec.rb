require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'バリデーション' do
    it 'room_nameが必須である' do
      room = build(:room, room_name: nil)
      expect(room).not_to be_valid
      expect(room.errors[:room_name]).to be_present
    end

    it 'room_nameがあれば有効である' do
      room = build(:room)
      expect(room).to be_valid
    end
  end

  describe 'アソシエーション' do
    it { should have_many(:room_users).dependent(:destroy) }
    it { should have_many(:users).through(:room_users) }
    it { should have_many(:messages).dependent(:destroy) }
    it { should have_one(:rule).dependent(:destroy) }
  end

  describe '#rule_selected?' do
    let(:room) { create(:room) }

    context 'ルールが設定されている場合' do
      before { create(:rule, room: room) }

      it 'trueを返す' do
        expect(room.rule_selected?).to be true
      end
    end

    context 'ルールが設定されていない場合' do
      it 'falseを返す' do
        expect(room.rule_selected?).to be false
      end
    end
  end
end
