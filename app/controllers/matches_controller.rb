class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!


  respond_to :html

  def index
    @matches = Match.all.where('accepted = true and challenger_won != null')
    respond_with(@matches)
  end

  def show
    respond_with(@match)
  end

  def new
    @match = Match.new
    @match.challenger_id = current_user.id
    respond_with(@match)
  end

  def conflicting
    @matches= Match.where('challenger_posted_challenger_won is not  null and challenged_posted_challenger_won is not null and challenger_won is null')
  end

  def edit
    return_to '/' and return if !current_user.admin
  end

  def pending 
    @matches = current_user.matches_pending
  end

  def submit 
    @matches = []
    current_user.matches_total.where(:challenger_won => nil).each do |x|
      if (x.challenger.id == current_user.id) then
        @matches.push(x) if x.challenger_posted_challenger_won == nil
      end
      if (x.challenged.id == current_user.id) then
        @matches.push(x) if x.challenged_posted_challenger_won == nil
     end
    end
  end

  def submit_value
    current_match = Match.find(params[:id])

    if (current_user == current_match.challenged)
      current_match.challenged_posted_challenger_won=!(params[:i_won])
      current_match.try_to_determine_winner
      current_match.save
    end
    
    if (current_user == current_match.challenger)
      current_match.challenger_posted_challenger_won=(params[:i_won])
      current_match.try_to_determine_winner
      current_match.save
    end
    

    redirect_to '/matches/submit' and return
  end

  def accept
    current_match = Match.find(params[:id])
    if (current_user == current_match.challenged)
      current_match.accepted=true
      current_match.save
    end
    render pending
  end

  def create
    @match = Match.new(match_params)
    @match.challenger_id = current_user.id
    
    @match.save
    respond_with(@match)
  end

  def update
    @match.update(match_params)
    respond_with(@match)
  end

  def destroy
    @match.destroy
    respond_with(@match)
  end

  private
    def set_match
      @match = Match.find(params[:id])
    end

    def match_params
      params.require(:match).permit(:challenger_id, :challenged_id, :challenger_won, :description, :proof)
    end
end
