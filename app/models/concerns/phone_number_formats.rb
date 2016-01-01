module PhoneNumberFormats
  extend ActiveSupport::Concern

  module ClassMethods
    def parse_phone_num(params)
      num = params[:number].dup
      fmt = I18n.t("phone_number.#{params[:format]}").dup
      PhoneNumber::Number.parse(num).to_s(fmt)
    end
  end

end
