# encoding: utf-8
#require "i18n"
require "numbers_and_words"
require "activesupport" unless defined?(ActiveSupport)
require "MX/numero_romano"
require "MX/ID/version"
require "MX/ID/auxiliar"
require "MX/ID/RFC"

if defined?(I18n) # Dependencia de numbers_and_words
  I18n.enforce_available_locales = false
  I18n.default_locale = :es
end