class Movie < ApplicationRecord
    include Swagger::Blocks

    swagger_schema :Movie do
        key :required, [:id, :title, :created_at, :update_at]
        property :id do
            key :type, :integer
        end
        property :title do
            key :type, :string
        end
        property :created_at do
            key :type, :string
            key :format, :date
        end
        property :update_at do
            key :type, :string
            key :format, :date
        end
    end
    belongs_to :user
end
