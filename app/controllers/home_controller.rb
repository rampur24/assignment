class HomeController < ApplicationController

 def new_home
  @userpost = Userpost.new		
 end	

 def create_home
 	 #debugger
  @userpost = Userpost.new(userpost_params)
  if @userpost.valid?
    @userpost.save
    flash[:notice] = 'Welcome.'
    redirect_to :index
  else
    render :action => "new_home"
  end
 end

 def index
    @userposts = Userpost.all
  end
 def edit
   @userpost = Userpost.find(params[:id])
 end

 def update
    @userpost = Userpost.find(params[:id])

    if @userpost.update(userpost_params)
      redirect_to :index
    else
      render :edit
    end
 end

 def destroy
    @userpost = Userpost.find(params[:id])
    @userpost.destroy
    redirect_to index_path
  end

 private
  def userpost_params
      params.require(:userpost).permit(:title, :description, :image)
  end
  
end
