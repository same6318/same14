class Post < ApplicationRecord

    validates :title, presence: { message: 'は1文字以上入力してください'}
    validates :content, presence: { message: 'は1文字以上入力してください'} 
    validates :content, length: { in: 1..140, message: 'は1文字以上140字以内で入力してください' }

end
