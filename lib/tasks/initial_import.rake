require 'rake'
require './lib/brief_name_generator.rb'
require './lib/average_position_age_diff_calculator.rb'

desc 'import players from CBS'
task :initial_import => :environment do
  baseball_players = HTTParty.get("https://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=baseball&response_format=JSON")["body"]["players"]
  basketball_players = HTTParty.get("https://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=basketball&response_format=JSON")["body"]["players"]
  football_players = HTTParty.get("https://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=football&response_format=JSON")["body"]["players"]

  baseball_players.each do |player|
    player["sport"] = "baseball"
  end

  basketball_players.each do |player|
    player["sport"] = "basketball"
  end

  # differentiate basketball C's (centers) from baseball C's (catchers)
  basketball_players.select { |player| player["position"] == "C" }.map { |player| player["position"] = "Ce" }

  football_players.each do |player|
    player["sport"] = "football"
  end

  # remove positionless players and team records from the dataset
  all_players = (baseball_players + basketball_players + football_players)
                .reject { |player| ["TQB", "D", "DST", "ST", "PS", "G", "null", ""].include? player["position"] }
  all_positions = all_players.map { |player| player["position"] }.uniq

  average_age_by_position = all_positions.each_with_object({}) do |position, hash|
    calculator = AveragePositionAgeDiffCalculator.new
    average_position_age = calculator.calculate_position_average_age(all_players, position)
    hash[position] = average_position_age
  end

  all_players.each do |player|
    generator = BriefNameGenerator.new
    name_brief = generator.generate_brief_name(player["firstname"], player["lastname"], player["sport"])

    player_record = Player.new({ full_name: player["fullname"],
                    first_name: player["firstname"],
                    last_name: player["lastname"],
                    position: player["position"],
                    age: player["age"],
                    sport: player["sport"],
                    name_brief: name_brief,
                    average_position_age_diff: player["age"] ? player["age"] - average_age_by_position[player["position"]] : nil
                  })
    player_record.save
  end
end
