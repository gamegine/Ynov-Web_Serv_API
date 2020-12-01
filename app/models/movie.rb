class Movie < ApplicationRecord
    belongs_to :user
    has_many :watchs, dependent: :destroy
end
