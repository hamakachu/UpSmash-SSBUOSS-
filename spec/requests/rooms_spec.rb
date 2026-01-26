require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  describe "GET /rooms" do
    it "ルーム一覧が表示される" do
      get rooms_path
      expect(response).to have_http_status(:ok)
    end

    it "ルームが作成日時の降順で表示される" do
      room1 = create(:room, created_at: 1.day.ago)
      room2 = create(:room, created_at: 1.hour.ago)

      get rooms_path
      expect(response.body).to match(/#{room2.room_name}.*#{room1.room_name}/m)
    end
  end

  describe "GET /rooms/new" do
    before { sign_in user }

    it "新規ルーム作成フォームが表示される" do
      get new_room_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /rooms" do
    before { sign_in user }

    context "有効なパラメータの場合" do
      let(:valid_params) do
        {
          room: {
            room_name: "テストルーム"
          }
        }
      end

      it "ルームが作成される" do
        expect {
          post rooms_path, params: valid_params
        }.to change(Room, :count).by(1)
      end

      it "ホストユーザーが自動的にルームに追加される" do
        post rooms_path, params: valid_params
        room = Room.last
        expect(room.users).to include(user)
      end

      it "ルーム詳細ページにリダイレクトされる" do
        post rooms_path, params: valid_params
        expect(response).to redirect_to(room_path(Room.last))
      end
    end

    context "無効なパラメータの場合" do
      let(:invalid_params) do
        {
          room: {
            room_name: nil
          }
        }
      end

      it "ルームが作成されない" do
        expect {
          post rooms_path, params: invalid_params
        }.not_to change(Room, :count)
      end

      it "newテンプレートが再表示される" do
        post rooms_path, params: invalid_params
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end

      it "エラーメッセージが表示される" do
        post rooms_path, params: invalid_params
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "GET /rooms/:id" do
    let(:room) { create(:room, host_user: user) }

    before do
      create(:room_user, room: room, user: user)
      sign_in user
    end

    it "ルーム詳細ページが表示される" do
      get room_path(room)
      expect(response).to have_http_status(:ok)
    end

    it "Presenterが正しく初期化される" do
      get room_path(room)
      expect(assigns(:presenter)).to be_a(RoomShowPresenter)
      expect(assigns(:presenter).room).to eq(room)
    end

    it "認証されていない場合はリダイレクトされる" do
      sign_out user
      get room_path(room)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST /rooms/:id/join" do
    let(:room) { create(:room, host_user: user) }

    before do
      create(:room_user, room: room, user: user)
      sign_in user2
    end

    context "有効な参加の場合" do
      it "ユーザーがルームに参加できる" do
        expect {
          post join_room_path(room)
        }.to change(RoomUser, :count).by(1)
      end

      it "ルーム詳細ページにリダイレクトされる" do
        post join_room_path(room)
        expect(response).to redirect_to(room_path(room))
      end
    end

    context "既に参加済みの場合" do
      before { create(:room_user, room: room, user: user2) }

      it "ルームに参加できない" do
        expect {
          post join_room_path(room)
        }.not_to change(RoomUser, :count)
      end

      it "ルーム一覧ページにリダイレクトされる" do
        post join_room_path(room)
        expect(response).to redirect_to(rooms_path)
      end

      it "エラーメッセージが表示される" do
        post join_room_path(room)
        expect(flash[:alert]).to eq('既にこのルームに参加しています')
      end
    end

    context "定員に達している場合" do
      let(:user3) { create(:user) }

      before do
        create(:room_user, room: room, user: user2)
        sign_in user3
      end

      it "ルームに参加できない" do
        expect {
          post join_room_path(room)
        }.not_to change(RoomUser, :count)
      end

      it "エラーメッセージが表示される" do
        post join_room_path(room)
        expect(flash[:alert]).to eq('このルームはすでに定員に達しています')
      end
    end
  end

  describe "DELETE /rooms/:id" do
    let(:room) { create(:room, host_user: user) }

    before do
      create(:room_user, room: room, user: user)
      sign_in user
    end

    it "ルームが削除される" do
      expect {
        delete room_path(room)
      }.to change(Room, :count).by(-1)
    end

    it "ルーム一覧ページにリダイレクトされる" do
      delete room_path(room)
      expect(response).to redirect_to(rooms_path)
    end

    it "ルームに紐づくRoomUserも削除される（dependent: :destroy）" do
      expect {
        delete room_path(room)
      }.to change(RoomUser, :count).by(-1)
    end
  end
end
