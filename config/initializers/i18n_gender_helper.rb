# typed: true
# frozen_string_literal: true

def tg(key, gender)
  suffix = gender.to_s.first
  I18n.t("#{key}_#{suffix}", default: I18n.t(key))
end
