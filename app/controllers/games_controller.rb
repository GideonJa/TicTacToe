class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  

  # GET /games/new
  def new
    @game = Game.new(level: "1", current_player: "x", name: "s", status: "comp")

  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)
   if @game.status == 'comp'
      @game = @game.next_move 
    else
      @game.rank
      @game.level +=1
    end
  

    render :edit

    # respond_to do |format|
    #   if @game.save
    #     format.html { redirect_to @game, notice: 'Game was successfully created.' }
    #     format.json { render :show, status: :created, location: @game }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @game.errors, status: :unprocessable_entity }
    #   end
    # end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
       params.require(:game).permit(:name,  :current_player, :level, :name, :status, :board => [])
    end
end
