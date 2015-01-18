class UserInfoController < ApplicationController
  def show
  	@user=User.find(params[:id])
  end

  def all
  	@users=User.all
  end
end
