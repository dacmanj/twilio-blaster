module PhoneNumberFormats
  extend ActiveSupport::Concern

  module ClassMethods
    def parse_phone_num(params)
      num = params[:number].dup.to_s.gsub(/[^0-9]/, "")
      fmt = FORMAT[params[:format]].dup
      PhoneNumber::Number.parse(num).to_s(fmt)
    end
    def phone_number_format(params)
      FORMAT[params.to_sym] || formats
    end
    def to_raw(num)
      parse_phone_num({number: num, format: :raw})
    end
    def to_twilio(num)
      parse_phone_num({number: num, format: :twilio})
    end
  end
  def to_raw
    self.phone_number.to_s(FORMAT[:raw])
  end
  def to_twilio
    self.phone_number.to_s(FORMAT[:twilio])
  end
  FORMAT = {
        twilio: "+%c%a%m%p",
        raw: "%C%a%m%p"
  }
end
