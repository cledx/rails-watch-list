class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @bookmark.list_id = @list.id
    @bookmark.save
    redirect_to list_path(@list)
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    @list = List.find(params[:id])

    raise
    redirect_to list_path(@list)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :list_id, :comment)
  end
end
