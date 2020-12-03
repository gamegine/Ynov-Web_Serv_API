class Watch < ApplicationRecord
  include Swagger::Blocks

    swagger_schema :Watch do
      key :required, [:user_id, :movie_id, :rating, :comment, :created_at, :updated_at]
      property :user_id do
          key :type, :integer
      end
      property :movie_id do
        key :type, :integer
      end
      property :rating do
        key :type, :integer
      end
      property :comment do
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
  belongs_to :movie

end
