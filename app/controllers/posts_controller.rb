class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    def index
        @posts = Post.all #パラメータ無しでエラーになるので、先にモデルを生成する。
        #allはメソッドの一種で、そのモデルがやりとりしているデータベースのテーブルに保存されている、全てのレコードをまとめて取得する
    end

    def show
        #@post = Post.find(params[:id])
        #binding.irb
        #Railsでは、コントローラーのアクションが実行された後、
        #結果を表示するためのビューテンプレートを探す。showアクションでは、show.html.erbという名前のビューテンプレートが必要。
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params) #入力された値を引数にとって、インスタンス化する
        #binding.irb
        #この時点の@postの中身{id: nil,title: "test3",content: "デバッグ",created_at: nil,updated_at: nil}
        #@post[:title]="test3"
        if @post.save #Post Createアクションが呼ばれて、実行出来たら。
            redirect_to posts_path, notice: '投稿できました'#started Getで/postsを取ってくる。＝画面移動
        else
            # flash.now[:alert] = "titleを入力してください" 
            # flash.now[:alert] = "Contentは1文字以上140字以内で入力してください" #これを書いただけでは表示されるわけではない。viewにも記載が必要。
            render :new
        end
        
    end

    def edit #1を選択した状態で編集に飛ぶと、Started GET "/posts/1/edit"
        #Parameters: {"id"=>"1"}で取得済みだが、データは無い
        #@post = Post.find(params[:id])
        #@postにfindメソッドで見つけたParameters: {"id"=>"1"}のデータが入る。
        #binding.irb
    end
    #編集はここまでで完了。次はupdateする。The action 'update' could not be found for PostsController

    def update
        # @post = Post.find(params[:id])
        #binding.irb
        if @post.update(post_params) #引数にpost_paramsメソッドで取得したものを渡す
            redirect_to posts_path
        else
            # flash.now[:alert] = "titleを入力してください" 
            # flash.now[:alert] = "Contentは1文字以上140字以内で入力してください" #これを書いただけでは表示されるわけではない。viewにも記載が必要。
            render :edit
        end
    end

    def destroy
        #@post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
    end

    private

    def post_params 
        params.require(:post).permit(:title, :content)
        #paramsはRailsでhttpリクエストから送信された＝form_withで送信されたパラメータを取得するためのオブジェクト。
        #require（：モデル名）=モデルからその値を取得する際、postという名前にする。post_params
        #permit（：許可するパラメータ）=requireでpostモデルにtitleとcontentが許可され、post[title]という名前でhtmlに表示される。
    end

    def set_post
        @post = Post.find(params[:id])
    end

end
