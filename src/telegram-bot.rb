
require 'telegram/bot'

token = '211537550:AAGSZIPYI1SaBDYtssv8dNGC81rD-rdJQTU'

Telegram::Bot::Client.run(token, logger: Logger.new($stdout)) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
   	else
   		bot.logger.info message.text
    end
  end
end