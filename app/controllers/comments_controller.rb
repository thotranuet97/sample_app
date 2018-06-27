class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def show
  	@comments = @micropost.comments.all
    @comment = @micropost.comments.build
  end
  
  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to micropost_path(@comment.micropost_id), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
  	@comment = Comment.find(params[:id])
  	micropost = @comment.micropost
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to micropost, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :micropost_id)
    end
end
