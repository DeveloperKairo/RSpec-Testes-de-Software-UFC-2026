# Gerenciador de Tarefas (Task Manager)

Uma aplicação robusta em Ruby on Rails desenvolvida para o gerenciamento de projetos e tarefas. Este repositório demonstra a implementação de uma API RESTful completa em conjunto com uma interface web clássica renderizada no servidor (SSR), construída com um forte foco em testes automatizados utilizando a biblioteca RSpec.

## Funcionalidades

- **Autenticação de Usuários**: Suporte a dupla autenticação, utilizando cookies de sessão tradicionais para a interface web e autenticação baseada em tokens (Bearer Token) para consumo via API.
- **Gerenciamento de Projetos e Tarefas**: Operações completas de CRUD (Criação, Leitura, Atualização e Exclusão) para projetos e suas respectivas tarefas.
- **Isolamento de Dados**: Políticas rígidas de autorização no backend, garantindo que os usuários possam acessar e manipular apenas os seus próprios dados.
- **Integração Web e API**: Controladores unificados projetados para processar e responder eficientemente tanto a requisições no formato `HTML` quanto `JSON`.
- **Testes Automatizados**: Ampla cobertura de testes, abrangendo Testes Unitários (Models) e Testes de Integração (Request Specs).

## Requisitos do Sistema

Certifique-se de ter as seguintes ferramentas instaladas antes de configurar o projeto:

- Ruby 3.4.8
- Ruby on Rails 8.1.3.1
- SQLite3
- Bundler

## Instalação e Configuração

Siga os passos abaixo para configurar o projeto em seu ambiente local:

1. **Clonar o repositório**
   ```bash
   git clone <url_do_repositorio>
   cd rspec_demo
   ```

2. **Instalar as dependências**
   ```bash
   bundle install
   ```

3. **Configurar o banco de dados**
   Execute o comando abaixo para criar o banco de dados local e rodar todas as migrações necessárias:
   ```bash
   bin/rails db:prepare
   ```

## Executando a Aplicação

Para iniciar o servidor de desenvolvimento local, execute o seguinte comando:

```bash
bin/rails server
```

A aplicação estará acessível através do endereço `http://localhost:3000`.

## Executando a Suíte de Testes

Este projeto utiliza o RSpec para a automação e validação de código. A suíte de testes cobre regras de negócio, validações de modelo, associações no banco de dados e o comportamento correto dos endpoints da API.

Para executar a suíte completa de testes, utilize o comando:

```bash
bundle exec rspec
```

Para visualizar a documentação detalhada de cada teste executado no terminal, utilize:

```bash
bundle exec rspec --format doc
```

## Estrutura Principal da Aplicação

- **Models**: Contém a lógica de negócios e as validações de dados (`User`, `Project`, `Task`).
- **Controllers**: Responsáveis pelo roteamento e processamento das requisições web e da API.
- **Views**: Templates HTML/ERB organizados que fornecem a interface gráfica final ao usuário.
- **Specs**: Diretório `spec/` contendo todos os arquivos de testes automatizados do RSpec.
