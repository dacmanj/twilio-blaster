require 'active_support/concern'

module PhoneNumberFormats
  extend ActiveSupport::Concern
  class_methods do
    def e164(num)
      Phonelib.parse(num).e164
    end
    def phone_numbers(obj)
      number_arr = []
      obj.each{ |c|
        number_arr.push c.e164
      }
      number_arr
    end
  end

  def e164
    Phonelib.parse(self[:phone_number]).e164
  end
  def format_phone_number
    self[:phone_number] = Phonelib.parse(self[:phone_number]).e164
  end
end
