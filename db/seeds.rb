# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Populando banco de dados de desenvolvimento..."

user = User.find_or_create_by!(email: "admin@example.com") do |u|
  u.name = "Administrador"
  u.age = 30
end

project1 = user.projects.find_or_create_by!(name: "Projeto Backend API") do |p|
  p.description = "Criar todos os endpoints REST em Ruby on Rails"
end

project2 = user.projects.find_or_create_by!(name: "Projeto Frontend View") do |p|
  p.description = "Construir a interface do usuário com um framework Javascript"
end

project1.tasks.find_or_create_by!(title: "Configurar banco") do |t|
  t.description = "Rodar migrations e verificar schema"
  t.status = "completed"
end

project1.tasks.find_or_create_by!(title: "Criar Controllers") do |t|
  t.description = "Implementar CRUD completo para Projects e Tasks"
  t.status = "in_progress"
end

project2.tasks.find_or_create_by!(title: "Configurar repositório do front") do |t|
  t.description = "Inicializar vite ou create-react-app"
  t.status = "pending"
end

puts "Seed concluído com sucesso!"
