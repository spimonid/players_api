class AveragePositionAgeDiffCalculator
  # changing basketball C to Ce means
  # all positions are unique, meaning
  # breaking down by sport is not necessary
  def calculate_position_average_age(players, position)
    players_in_position = players.select { |player| player["age"] != nil && player["position"] == position }
    total_age_in_position = players_in_position.map { |player| player["age"] }.compact.sum
    
    (total_age_in_position / players_in_position.length).round
  end
end
