class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
    @movies = Movie.order(title: :asc)
  end

  def create
    @list = List.find(params[:list_id])
    @bookmarks = @list.bookmarks.all
    @newbookmark = Bookmark.new(bookmark_params)
    @newbookmark.list = @list
    if @newbookmark.save
      redirect_to list_path(@newbookmark.list)
    else
      render "lists/show", status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    @list = List.find(params[:id])

    redirect_to list_path(@list)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :list_id, :comment)
  end
end
