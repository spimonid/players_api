require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @james = Player.new({ first_name: "James", last_name: "Brown", name_brief: "James B.", position: "1B", sport: "basketball" })

    @james.save!
    @james = Player.last

    @john = Player.new({ first_name: "John", last_name: "Smith", full_name: "John Smith", name_brief: "J. Smith", 
                         sport: "football", age: 28, position: "QB", average_position_age_diff: 2 })
    @john.save!
    @john = Player.last

    @jack = Player.new({ first_name: "Jack", last_name: "Johnson", full_name: "Jack Johnson", name_brief: "J. J.", 
                        sport: "basketball", age: nil, position: "SF", average_position_age_diff: nil })
    @jack.save!
    @jack = Player.last
  end

  test "/show/:id" do
    get "/players/#{@jack.id}"
    assert_response :success
    assert_includes response.body, "Jack"
    assert_equal response.body.scan("null").length, 2
  end

  test "/search" do
    get "/search", params: { sport: "basketball", feeling_lucky: true }
    assert_response :success
    feeling_lucky_response_length = response.body.length

    get "/search", params: { sport: "basketball" }
    assert_response :success
    full_response_length = response.body.length
    assert_not_equal feeling_lucky_response_length, full_response_length
  end
end
