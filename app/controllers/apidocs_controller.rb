class ApidocsController < ActionController::Base
    include Swagger::Blocks

    swagger_root do
        key :swagger, '2.0'
        info do
            key :version, '1.0.0'
            key :title, 'Swagger API-YNOV'
            key :description, 'Find more info in github : https://github.com/gamegine/Ynov-Web_Serv_API'
            key :termsOfService, 'http://helloreverb.com/terms/'
            contact do
                key :name, 'apiteam@wordnik.com'
            end
            license do
                key :name, 'MIT'
            end
        end
        tag do
            key :name, 'Project API-YNOV'
            key :description, 'Sample API operations'
            externalDocs do
                key :description, 'Find more info here'
                key :url, 'https://swagger.io'
            end
        end
        key :host, 'localhost:3000'
        key :basePath, '/api/v1/'
        key :consumes, ['application/json']
        key :produces, ['application/json']
    end

    # A list of all classes that have swagger_* declarations.
    SWAGGERED_CLASSES = [
        Api::V1::MoviesController,
        Movie,
        self,
    ].freeze

    def index
        render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
    end
end