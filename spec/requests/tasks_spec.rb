require 'rails_helper'

RSpec.describe "Tasks API", type: :request do
  let!(:user) { User.create!(name: "Maria", email: "maria@email.com", age: 30, password: "password123") }
  let!(:other_user) { User.create!(name: "Joao", email: "joao@email.com", age: 20, password: "password123") }
  
  let!(:project) { Project.create!(name: "Proj", description: "Desc", user: user) }
  let!(:other_project) { Project.create!(name: "Outro Proj", description: "Desc", user: other_user) }
  
  let!(:task) { Task.create!(title: "Estudar RSpec", description: "Estudar muito todos os dias", status: "pending", project: project) }

  let(:headers) { { "Authorization" => "Bearer #{user.auth_token}", "Accept" => "application/json" } }

  describe "GET /projects/:project_id/tasks" do
    it "lista as tarefas de um projeto pertencente ao usuário logado" do
      get "/projects/#{project.id}/tasks", headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.length).to eq(1)
      expect(json.first["title"]).to eq("Estudar RSpec")
    end

    it "retorna 404 se tentar listar tarefas de um projeto de outro usuário" do
      get "/projects/#{other_project.id}/tasks", headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /projects/:project_id/tasks" do
    it "cria uma tarefa no projeto do usuário" do
      expect {
        post "/projects/#{project.id}/tasks", params: {
          task: {
            title: "Nova Tarefa",
            description: "Descrição muito grande",
            status: "pending"
          }
        }, headers: headers
      }.to change(Task, :count).by(1)

      expect(response).to have_http_status(:created)
    end

    it "não permite criar tarefa no projeto de outro usuário" do
      expect {
        post "/projects/#{other_project.id}/tasks", params: {
          task: {
            title: "Nova Tarefa Invasora",
            status: "pending"
          }
        }, headers: headers
      }.not_to change(Task, :count)

      expect(response).to have_http_status(:not_found)
    end
  end
end
