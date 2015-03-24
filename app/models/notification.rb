class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  validates :notificatable_url, :notificatable_type, :body, presence: true

  field :notificatable_url, type: String
  field :notificatable_type, type: String
  field :body, type: String
  field :was_read, type: Boolean, default: false
end
