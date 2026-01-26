class RoomShowPresenter
  attr_reader :room

  def initialize(room, current_user)
    @room = room
    @current_user = current_user
  end

  # N+1を回避した参加者取得
  def participants
    @participants ||= @room.users.includes(image_attachment: :blob).order(:id)
  end

  # ホスト判定
  def host?(user)
    user.id == @room.host_user_id
  end

  # 現在のユーザーがホストか
  def current_user_is_host?
    @current_user.id == @room.host_user_id
  end

  # ルーム削除権限
  def can_delete_room?
    current_user_is_host?
  end

  # ルールが選択済みか
  def rule_selected?
    @room.rule_selected?
  end

  # ルール情報
  def rule
    @room.rule
  end

  # N+1を回避したメッセージ取得
  def messages
    @messages ||= @room.messages.includes(user: { image_attachment: :blob }).order(:created_at)
  end

  # フォーマット名の取得
  def format_name
    return nil unless rule_selected?
    Format.find(rule.format_id).name
  end

  # 試合数名の取得
  def match_count_name
    return nil unless rule_selected?
    MatchCount.find(rule.match_count_id).name
  end

  # 通話可能か
  def voice_chat_available?
    return false unless rule_selected?
    rule.voice_chat_id == 2
  end

  # フォーマット画像パスの取得
  def format_image_path
    return nil unless rule_selected?
    case rule.format_id
    when 2
      "スマメイト.png"
    when 3
      "篝火.png"
    else
      nil
    end
  end
end
