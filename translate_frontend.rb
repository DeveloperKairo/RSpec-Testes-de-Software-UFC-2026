require 'fileutils'

def translate_file(path, translations)
  content = File.read(path)
  original = content.dup
  translations.each do |eng, pt|
    content.gsub!(eng, pt)
  end
  File.write(path, content) if original != content
end

auth_translations = {
  "Welcome back" => "Bem-vindo de volta",
  "Sign in to your account" => "Entre na sua conta",
  "Email address" => "Endereço de email",
  "Password" => "Senha",
  "Sign in" => "Entrar",
  "Don't have an account?" => "Não tem uma conta?",
  "Sign up" => "Cadastre-se",
  "Create your account" => "Crie sua conta",
  "Start organizing your tasks today." => "Comece a organizar suas tarefas hoje.",
  "Full name" => "Nome completo",
  "Age" => "Idade",
  "Confirm password" => "Confirmar senha",
  "Create account" => "Criar conta",
  "Already have an account?" => "Já tem uma conta?",
  "Sign out" => "Sair"
}

translate_file('app/views/sessions/new.html.erb', auth_translations)
translate_file('app/views/users/new.html.erb', auth_translations)

sidebar_translations = {
  "Dashboard" => "Painel",
  "Projects" => "Projetos",
  "Sign out" => "Sair"
}
translate_file('app/views/shared/_sidebar.html.erb', sidebar_translations)

dashboard_translations = {
  "Dashboard" => "Painel",
  "Overview of your projects and tasks" => "Visão geral de seus projetos e tarefas",
  "Total Projects" => "Total de Projetos",
  "Pending Tasks" => "Tarefas Pendentes",
  "Completed Tasks" => "Tarefas Concluídas",
  "Your Projects" => "Seus Projetos",
  "New Project" => "Novo Projeto",
  "Tasks" => "Tarefas",
  "View Project" => "Ver Projeto",
  "View all projects" => "Ver todos os projetos"
}
translate_file('app/views/dashboard/index.html.erb', dashboard_translations)

projects_index_translations = {
  "Projects" => "Projetos",
  "Manage your projects and tasks" => "Gerencie seus projetos e tarefas",
  "New Project" => "Novo Projeto",
  "No projects yet." => "Nenhum projeto ainda.",
  "Create your first project to get started." => "Crie seu primeiro projeto para começar.",
  "Tasks" => "Tarefas",
  "View Project" => "Ver Projeto"
}
translate_file('app/views/projects/index.html.erb', projects_index_translations)

projects_show_translations = {
  "Edit Project" => "Editar Projeto",
  "Delete Project" => "Excluir Projeto",
  "Are you sure you want to delete this project?" => "Tem certeza de que deseja excluir este projeto?",
  "Tasks" => "Tarefas",
  "New Task" => "Nova Tarefa",
  "Back to Projects" => "Voltar aos Projetos",
  "No tasks yet." => "Nenhuma tarefa ainda.",
  "Create the first task for this project." => "Crie a primeira tarefa para este projeto.",
  "Status" => "Status",
  "Pending" => "Pendente",
  "Completed" => "Concluída",
  "Edit" => "Editar",
  "Delete" => "Excluir"
}
translate_file('app/views/projects/show.html.erb', projects_show_translations)

projects_form_translations = {
  "Project name" => "Nome do projeto",
  "Description" => "Descrição",
  "e.g., Website Redesign" => "ex., Redesign do Site",
  "Save Project" => "Salvar Projeto",
  "Cancel" => "Cancelar"
}
translate_file('app/views/projects/_form.html.erb', projects_form_translations)

projects_new_edit_translations = {
  "New Project" => "Novo Projeto",
  "Create a new project to organize your tasks." => "Crie um novo projeto para organizar suas tarefas.",
  "Edit Project" => "Editar Projeto",
  "Update your project details." => "Atualize os detalhes do seu projeto."
}
translate_file('app/views/projects/new.html.erb', projects_new_edit_translations)
translate_file('app/views/projects/edit.html.erb', projects_new_edit_translations)

tasks_form_translations = {
  "Task title" => "Título da tarefa",
  "e.g., Fix navigation bug" => "ex., Corrigir bug de navegação",
  "Description" => "Descrição",
  "Status" => "Status",
  "Pending" => "Pendente",
  "Completed" => "Concluída",
  "Save Task" => "Salvar Tarefa",
  "Cancel" => "Cancelar"
}
translate_file('app/views/tasks/_form.html.erb', tasks_form_translations)

tasks_new_edit_translations = {
  "New Task" => "Nova Tarefa",
  "Add a new task to" => "Adicionar nova tarefa a",
  "Edit Task" => "Editar Tarefa",
  "Update task details." => "Atualize os detalhes da tarefa."
}
translate_file('app/views/tasks/new.html.erb', tasks_new_edit_translations)
translate_file('app/views/tasks/edit.html.erb', tasks_new_edit_translations)

puts "Translations applied!"
