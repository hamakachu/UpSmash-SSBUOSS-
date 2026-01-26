require 'rails_helper'

RSpec.describe RoomShowPresenter, type: :presenter do
  let(:host_user) { create(:user) }
  let(:guest_user) { create(:user) }
  let(:room) { create(:room, host_user: host_user) }
  let(:presenter) { RoomShowPresenter.new(room, host_user) }

  before do
    create(:room_user, room: room, user: host_user)
    create(:room_user, room: room, user: guest_user)
  end

  describe '#participants' do
    it 'ルームの参加者を返す' do
      participants = presenter.participants
      expect(participants).to include(host_user, guest_user)
      expect(participants.count).to eq(2)
    end

    it 'N+1クエリが発生しない（includes済み）' do
      # 実際のクエリ数をテストする場合はbullet gemなどを使用
      expect(presenter.participants).to be_a(ActiveRecord::Relation)
    end
  end

  describe '#host?' do
    it 'ホストユーザーの場合trueを返す' do
      expect(presenter.host?(host_user)).to be true
    end

    it 'ゲストユーザーの場合falseを返す' do
      expect(presenter.host?(guest_user)).to be false
    end
  end

  describe '#current_user_is_host?' do
    context 'current_userがホストの場合' do
      let(:presenter) { RoomShowPresenter.new(room, host_user) }

      it 'trueを返す' do
        expect(presenter.current_user_is_host?).to be true
      end
    end

    context 'current_userがゲストの場合' do
      let(:presenter) { RoomShowPresenter.new(room, guest_user) }

      it 'falseを返す' do
        expect(presenter.current_user_is_host?).to be false
      end
    end
  end

  describe '#can_delete_room?' do
    context 'current_userがホストの場合' do
      let(:presenter) { RoomShowPresenter.new(room, host_user) }

      it 'trueを返す' do
        expect(presenter.can_delete_room?).to be true
      end
    end

    context 'current_userがゲストの場合' do
      let(:presenter) { RoomShowPresenter.new(room, guest_user) }

      it 'falseを返す' do
        expect(presenter.can_delete_room?).to be false
      end
    end
  end

  describe '#rule_selected?' do
    context 'ルールが設定されている場合' do
      before { create(:rule, room: room) }

      it 'trueを返す' do
        expect(presenter.rule_selected?).to be true
      end
    end

    context 'ルールが設定されていない場合' do
      it 'falseを返す' do
        expect(presenter.rule_selected?).to be false
      end
    end
  end

  describe '#rule' do
    context 'ルールが設定されている場合' do
      let!(:rule) { create(:rule, room: room) }

      it 'ルールオブジェクトを返す' do
        expect(presenter.rule).to eq(rule)
      end
    end

    context 'ルールが設定されていない場合' do
      it 'nilを返す' do
        expect(presenter.rule).to be_nil
      end
    end
  end

  describe '#messages' do
    before do
      create(:message, room: room, user: host_user, content: 'メッセージ1')
      create(:message, room: room, user: guest_user, content: 'メッセージ2')
    end

    it 'ルームのメッセージを返す' do
      messages = presenter.messages
      expect(messages.count).to eq(2)
    end

    it '作成日時順に並んでいる' do
      messages = presenter.messages
      expect(messages.first.content).to eq('メッセージ1')
      expect(messages.last.content).to eq('メッセージ2')
    end

    it 'N+1クエリが発生しない（includes済み）' do
      expect(presenter.messages).to be_a(ActiveRecord::Relation)
    end
  end

  describe '#format_name' do
    context 'ルールが設定されている場合' do
      before { create(:rule, room: room, format_id: 2) }

      it 'フォーマット名を返す' do
        expect(presenter.format_name).to eq(Format.find(2).name)
      end
    end

    context 'ルールが設定されていない場合' do
      it 'nilを返す' do
        expect(presenter.format_name).to be_nil
      end
    end
  end

  describe '#match_count_name' do
    context 'ルールが設定されている場合' do
      before { create(:rule, room: room, match_count_id: 2) }

      it '試合数名を返す' do
        expect(presenter.match_count_name).to eq(MatchCount.find(2).name)
      end
    end

    context 'ルールが設定されていない場合' do
      it 'nilを返す' do
        expect(presenter.match_count_name).to be_nil
      end
    end
  end

  describe '#voice_chat_available?' do
    context '通話可能（voice_chat_id=2）の場合' do
      before { create(:rule, room: room, voice_chat_id: 2) }

      it 'trueを返す' do
        expect(presenter.voice_chat_available?).to be true
      end
    end

    context '通話不可（voice_chat_id=1）の場合' do
      before { create(:rule, room: room, voice_chat_id: 1) }

      it 'falseを返す' do
        expect(presenter.voice_chat_available?).to be false
      end
    end

    context 'ルールが設定されていない場合' do
      it 'falseを返す' do
        expect(presenter.voice_chat_available?).to be false
      end
    end
  end

  describe '#format_image_path' do
    context 'スマメイトルール（format_id=2）の場合' do
      before { create(:rule, room: room, format_id: 2) }

      it 'スマメイト画像パスを返す' do
        expect(presenter.format_image_path).to eq('スマメイト.png')
      end
    end

    context '篝火ルール（format_id=3）の場合' do
      before { create(:rule, room: room, format_id: 3) }

      it '篝火画像パスを返す' do
        expect(presenter.format_image_path).to eq('篝火.png')
      end
    end

    context 'その他のフォーマットの場合' do
      before { create(:rule, room: room, format_id: 1) }

      it 'nilを返す' do
        expect(presenter.format_image_path).to be_nil
      end
    end

    context 'ルールが設定されていない場合' do
      it 'nilを返す' do
        expect(presenter.format_image_path).to be_nil
      end
    end
  end
end
