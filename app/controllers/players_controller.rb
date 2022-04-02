class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])

    render :json => @player.to_json( :except => [:full_name, :sport, :created_at, :updated_at] )
  end

  def search
    @result = Player.search(params)
    feeling_lucky = params.keys.include?("feeling_lucky")
    result = feeling_lucky ? @result.first : @result

    render :json => result.to_json( :except => [:full_name, :sport, :created_at, :updated_at] )
  end

  private

  def permitted_search_params
    params.permit(:sport, :position, :age, :min_age, :max_age, :first_letter_last_name)
  end
end
