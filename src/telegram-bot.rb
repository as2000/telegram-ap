require 'telegram/bot'
require 'json'
require 'net/http'


def get_date(date)
  date = date.split(",")
  time_part = DateTime.strptime(date[0],"%R:%S")
  date_part = DateTime.strptime(date[2],"%m/ %d/%Y")
  whole_date =DateTime.new(date_part.year, date_part.month, date_part.day, time_part.hour, time_part.min, time_part.sec, time_part.zone)
end




token = '211537550:AAGSZIPYI1SaBDYtssv8dNGC81rD-rdJQTU'
statHash ={:bodystat => {}}

#Telegram::Bot::Client.run(token, logger: Logger.new($stdout)) do |bot|
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    stats = message.text.split("\n")
    if stats[0] == "aiden" then
      stats.each do |stat|
        data = stat.split(":",2)

        case data[0]
        when "Time"
          date = get_date(data[1])
          puts date.to_s
          statHash[:bodystat][:date] = date.to_s
        when "Weight"
          statHash[:bodystat][:body_weight] = data[1].tr("kg", '')
        when "Body Water"
          statHash[:bodystat][:body_water] = data[1].tr("%", '')
        when "Body Fat"
          statHash[:bodystat][:body_fat] = data[1].tr("%", '')
        when "Bone"
          statHash[:bodystat][:bone_weight] = data[1].tr("%", '')
        when "BMI"
          statHash[:bodystat][:bmi] = data[1].tr("%", '')
        when "Visceral Fat"
          statHash[:bodystat][:visceral_fat] = data[1].tr("%", '')
        when "BMR"
          statHash[:bodystat][:bmr] = data[1].tr(" kcal", '')
        when "Muscle Mass"
          statHash[:bodystat][:muscle_mass] = data[1].tr("%", '')
        end
        
        
      end
      uri = URI.parse "http://localhost:3000"
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Post.new("/bodystats")
      req.content_type = 'application/json'
      req.body = statHash.to_json
      response = http.request(req)
      

    end
  end
end

