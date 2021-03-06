class  ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  def index
    @any_name =Article.all
  end

  def new
    @article =Article.new
  end

  def edit
    
  end


  def create
    #you can add the"debugger" for debugging and add in layouts --> application.html.erb--> write <%= debug(params) if Rails.env.development? %> to view the flow in the pages and hit ctrl +d to exit from debugging in rails server
    # render plain: params[:article].inspect   #This code is without validation
    # @article =Article.new(article_params)  #This code is without validation
    # @article.save                             #This code is without validation
    # redirect_to article_path(@article)       #This code is without validation
    @article =Article.new(article_params)  # this is taken from the new action
    @article.user = User.first  #for one to many association to create a userId while cretaing articles we need that user
    if @article.save 
      flash[:success] = "Article has successfully created"
      redirect_to article_path(@article)  #Show path
    else
      render 'new'
    end
  end
  
  def update  
    # @article = Article.find(params[:id])  # This is taken care from the edit action
    if @article.update(article_params)  # as in routes it shows that it take arguments we add the arguments
      flash[:success] = "Article has been successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end


  def show
    
  end

  def destroy    
    @article.destroy
    flash[:danger] = "Article has successfully deleted"
    redirect_to articles_path

  end


private
  def set_article
  @article =Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end



end 