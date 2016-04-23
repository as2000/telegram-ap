require 'telegram/bot'

token = '211537550:AAGSZIPYI1SaBDYtssv8dNGC81rD-rdJQTU'

#Telegram::Bot::Client.run(token, logger: Logger.new($stdout)) do |bot|
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    stats = message.text.split("\n")
    if stats[0] == "aiden" then
      stats.each do |stat|
        data = stat.split(":",2)

        case data[0]
        when "Time"
          time = DateTime.strptime(data[1], "%R:%S, %a,%m/ %d/%Y")
          puts "time is #{time}"
        when "Weight"
          puts "fatty"
        end
        #data = stat.split(":")[1].strip
        
      end
    end
  end
end

