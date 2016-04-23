require 'telegram/bot'

token = '211537550:AAGSZIPYI1SaBDYtssv8dNGC81rD-rdJQTU'

#Telegram::Bot::Client.run(token, logger: Logger.new($stdout)) do |bot|
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    stats = message.text.split("\n")
    stats.each do |stat|
      data = stat.split(":")[1]
      puts data
      #data = stat.split(":")[1].strip
      
    end
  end
end