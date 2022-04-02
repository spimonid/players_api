require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  test "saves with only necessary params" do
    player = Player.new({ first_name: "John", last_name: "Smith", name_brief: "J. Smith" })
    assert player.save
  end

  test "does not save if missing necessary param(s)" do
    player = Player.new({ first_name: "John", last_name: "Smith" })
    assert_not player.save
  end

  test "saves correctly with missing params" do
    player = Player.new({ first_name: "John", last_name: "Smith", name_brief: "J. Smith", sport: "football" })
    assert player.save
    assert Player.last["first_name"], "John"
    assert Player.last["sport"], "football"
  end

  test "saves all params correctly" do
    player = Player.new({ first_name: "John", last_name: "Smith", full_name: "John Smith", name_brief: "J. Smith", 
                          sport: "football", age: 28, position: "QB", average_position_age_diff: -4 })

    assert player.save
    assert Player.last["age"], 28

    # keys list vs. compacted keys list, i.e. get no nil values
    assert_equal Player.last.attributes.values.length, Player.last.attributes.values.compact.length

    player2 = Player.new({ first_name: "Jack", last_name: "Johnson", full_name: "Jack Johnson", name_brief: "J. J.", 
                           sport: "baseball", age: nil, position: "QB", average_position_age_diff: -4 })
    assert player2.save

    assert_nil Player.last["age"]
    assert_not_equal Player.last.attributes.values.length, Player.last.attributes.values.compact.length
  end
end
