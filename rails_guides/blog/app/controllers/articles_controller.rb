class ArticlesController < ApplicationController
    
    def show
        # display!
        @article = Article.find(params[:id])
    end

    def new
        # new article action
    end

    def create
        ### inital way to see what's going on (not super-useful)     
        #render plain: params[:article].inspect

        ### UNSAFE - yields security error:
        #@article = Article.new(params[:article])
        
        ### SAFE - but better refactore out into the below private method
        #@article = Article.new(params.require(:article).permit(:title, :text))

        @article = Article.new(article_params)

        @article.save
        redirect_to @article
    end

    private
        def article_params
            params.require(:article).permit(:title, :text)
        end
end
