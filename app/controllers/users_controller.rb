class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def profile
    @user = current_user
  end

  def profile_edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(params.require(:user).permit(:name, :introduction, :user_icon))
      flash[:notice] = "プロフィールの更新に成功しました。"
      redirect_to users_profile_path
    else
      render :profile_edit, status: :unprocessable_entity
    end
  end

  def posts
    @posts = current_user.posts.order(updated_at: :DESC)
  end

  def questions
    @questions = current_user.questions.order(created_at: :DESC)
  end

  def favorite_posts
    @favorites = current_user.favorites.order(created_at: :DESC)
  end

  def favorite_questions
    @favorites = current_user.q_favorites.order(created_at: :DESC)
  end
end
