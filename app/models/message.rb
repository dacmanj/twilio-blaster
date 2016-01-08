# == Schema Information
#
# Table name: messages
#
#  id                :integer          not null, primary key
#  body              :string
#  to_phone_number   :string
#  from_phone_number :string
#  status            :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  media_url         :string
#  direction         :string
#  message_type      :string
#

class Message < ActiveRecord::Base
  include Filterable
  include Authority::Abilities
  validates :body, presence: true
  validates :to_phone_number, presence: true
  validates :from_phone_number, presence: true


  scope :status, -> (status) { where status: status }
  scope :direction, -> (direction) { where direction: direction }

  has_and_belongs_to_many :contacts
  has_and_belongs_to_many :groups
  belongs_to :user
  has_many :message_logs, dependent: :destroy
  after_create :process_new_message

  def process_new_message
    if (self.direction == "incoming")
      #check to see if message from contact and if so re-write "caller" id
      self.from_phone_number = Contact.caller_id_lookup(self.from_phone_number)

      #send sms to administrators with incoming message
      admin_contact_ids = User.with_role(:admin).map{|x| x.contacts}.flatten.map{|x| x.id}
      Message.new(contact_ids: admin_contact_ids, from_phone_number: self.from_phone_number, to_phone_number: self.to_phone_number, message_type: "text", direction: "outgoing", status: "forwarding", body: "DO NOT REPLY... From #{self.from_phone_number}: #{self.body}").save
      self.status = "forwarded"
    end
    self.direction = "outgoing" if self.direction.blank?

    self.status = "pending"
    recipients = []
    self.groups.each { |g|
      g.contacts.each{ |c|
        self.contacts.push(c) unless self.contacts.include? c
      }
    }
    self.contacts.each { |c|
      recipients.push("#{c.name} <#{c.phone_number}>")
      Message.send_message to: c.phone_number, body: self.body, media_url: self.media_url, message_id: self.id, message_type: self.message_type
    }
    self.to_phone_number = recipients.join(", ")
    self.status = "sent"
    self.save
  end

  def self.send_message(msg)
    img = {
        :status_open_image => "https://www.opm.gov/img/Policy/SnowAndDismissal/status_open.jpg",
        :status_closed_image => "https://www.opm.gov/img/Policy/SnowAndDismissal/status_closed.jpg",
        :status_alert_image => "https://www.opm.gov/img/Policy/SnowAndDismissal/status_alert.jpg"
      }
      msg[:from] = msg[:from] || ENV['TWILIO_PHONE_NUMBER']
      msg[:media_url] = img[msg[:img].to_sym] if msg[:img].present?
      #filter parameters
      base_url = msg[:base_url] || ENV['BASE_URL'] #request.base_url

      #delete MMS if not used
      msg.delete(:media_url) if msg[:media_url].blank?
      client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
      msg[:status_callback] = base_url + '/twilio/status' #set callback for sms

      if msg[:message_type] == "Text" || msg[:message_type] == "Both"
        msg[:status_callback] = base_url + '/twilio/status' #set callback for sms
        message = client.messages.create msg.slice(:to, :from, :body, :media_url, :status_callback)
        MessageLog.new(sid: message.sid, to_phone_number: message.to, from_phone_number: message.from, message_type: "Text",  message_id: msg[:message_id], date_sent: Time.now).save
      end

      if msg[:message_type] == "Voice" || msg[:message_type] == "Both"
        msg[:url] = base_url + "/twilio/message?id=#{msg[:message_id]}"
        message = client.calls.create msg.slice(:to, :from, :url, :status_callback, 'IfMachine': "continue")
        MessageLog.new(sid: message.sid, to_phone_number: message.to, from_phone_number: message.from, message_type: "Voice",  message_id: msg[:message_id], date_sent: Time.now).save
      end
      message
  end

  def body_for_voice
    self.body.sub("PFLAG","P FLAG")
  end

end
