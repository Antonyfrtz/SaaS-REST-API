require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Todos API', type: :request do
  path '/todos' do
    post 'Creates a todo' do
      tags 'Todos'
      consumes 'application/json'
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          created_by: { type: :integer }
        },
        required: ['title', 'created_by']
      }

      response '201', 'todo created' do
        let(:valid_headers) { { 'Authorization' => 'Bearer token' } }
        let(:todo) { { title: 'Learn Elm', created_by: 1 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:valid_headers) { { 'Authorization' => 'Bearer token' } }
        let(:todo) { { title: 'Foobar' } }
        run_test!
      end
    end
  end

  path '/todos/{id}' do
    get 'Retrieves a todo' do
      tags 'Todos'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'todo found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            created_by: { type: :integer }
          },
          required: ['id', 'title', 'created_by']

        let(:id) { Todo.create(title: 'foo', created_by: 1).id }
        run_test!
      end

      response '404', 'todo not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
