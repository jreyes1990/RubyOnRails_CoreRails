# config/initializers/telegram_bot.rb
require 'telegram/bot'

Telegram::Bot::Client.run('5994065892:AAFCk_em6z-PZSEwkw-zAa5ACq8FYGeNwfw') do |bot|
  $telegram_bot = bot
end
