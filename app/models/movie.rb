class Movie < ApplicationRecord
    include Swagger::Blocks

    swagger_schema :Movie do
        key :required, [:id, :title]
        property :id do
            key :type, :integer
        end
        property :title do
            key :type, :string
        end
    end
    belongs_to :user
end
