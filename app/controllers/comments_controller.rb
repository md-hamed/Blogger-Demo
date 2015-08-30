class CommentsController < ApplicationController
  def create
    article = Article.find(params[:comment][:article_id])
    comment = article.comments.create(comment_params)

    flash[:notice] = "Your comment was added."
    # Comment.delay.total_word_count
    Delayed::Job.enqueue CountWordsJob.new
    redirect_to article_path(article)
  end

  private

  def comment_params
    params.require(:comment).permit(:article_id, :author_name, :body)
  end
end
