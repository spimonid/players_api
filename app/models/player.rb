class Player < ApplicationRecord
  scope :in_age_range, -> (min_age, max_age) { where("players.age >= ? AND players.age <= ?", min_age, max_age )}
  scope :match_first_letter, -> (first_letter_last_name) { where("substr(players.last_name, 1, 1) = ?", first_letter_last_name )}

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :name_brief, presence: true

  def self.search(params)
    players = Player.all
    players = players.in_age_range(params["min_age"], params["max_age"]) if params["min_age"] && params["max_age"]
    players = players.match_first_letter(params["first_letter_last_name"]) if params["first_letter_last_name"]

    players = players.where(sport: params["sport"]) if params["sport"]
    players = players.where(age: params["age"]) if params["age"]
    players = players.where(position: params["position"]) if params["position"]

    players
  end
end
