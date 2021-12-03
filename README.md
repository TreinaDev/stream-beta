# Stream Beta
## Sobre o Projeto:
Uma empresa de e-sports decidiu lançar uma plataforma para venda de vídeos de
gameplay e transmissão de competições. Para isso, a empresa quer utilizar a mais nova
ferramenta de pagamentos disponível no mercado. O objetivo deste projeto é construir em
equipes os MVPs destas duas empresas.
A plataforma de vídeos será gerenciada pelos administradores, que irão cadastrar os
jogadores, playlists de vídeos de gameplay e competições que serão transmitidas. A
plataforma vai oferecer a venda de diferentes pacotes, cada pacote pode incluir vídeos de
um ou vários streamers. Os vídeos serão cadastrados no Vimeo e devem ser exibidos de
forma ‘embutida’ (embedded) dentro da plataforma. Devem ser produzidas estatísticas de
acesso e visualização de vídeos de acordo com os acessos dos assinantes.

Os cadastros dos produtos da plataforma possuem ligação direta à plataforma de pagamentos ['Pagamentos Beta'](https://github.com/TreinaDev/pagamentos-beta) via API, para a geração de tokens necessários para cobranças dos produtos consumidos pelos assinantes e armazenamento de dados de pagamentos. Para 100% do funcionamento da Plataforma Beta certifique-se de que tenha os 2 projetos rodando.

## Pré-requisitos:

 * Ruby 3.0.2
 * Rails 6.1.4.1
 * NodeJs 12.22.6
 * Yarn 1.22.5

### Gems Complementares
### Testes

  * RSpec  
  * Capybara  
  * Shoulda Matchers  
  * Factory Bot Rails
  * Simplecov

#### Autorização/Autenticação

  * Devise
  * CPF/CNPJ
### Outras Gems

  * Pry-Byebug
  * Rubocop-Rails 
  * Ffaker - Para geração de dados, seja nos testes ou seed.
  * Faraday - Biblioteca para requisições HTTP/REST de APIs

## Funcões

### Administradores

  * Cadastram planos, streamers, playlists, vídeos e promoções na plataforma. 
  * Gerenciam toda e qualquer parte relacionada aos componentes da plataforma citados acima.

### Assinantes da Plataforma

  * No decorrer normal de funcionamento e conta, cadastram meios de pagamentos, assiste a vídeos e fazem assinaturas nos planos e tem acessos as playlists.

## Para execução do projeto: 

  * Clone o projeto em sua máquina

```
  git clone https://github.com/TreinaDev/stream-beta.git
```

### Instale as dependências necessárias:

  * Rode o comando: 
```
cd stream-beta
```
  * Após, rode  o comando: 
```
bin/setup
```
## Configuração do Banco de Dados

  * Rode o comando abaixo e preencha o banco de dados com os dados pré-existentes da aplicação.
```
rails db:seed
```
 * Rode o comando abaixo para executar a aplicação.
```
rails server
```
 * Vá ao seu navegador e acesse:
```
http://localhost:3000
```
## Observações:

  * Usuários administradores tem como obrigatoriedade a utilização do domínio @gamestream.com.br no momento do cadastro, em meio ao banco de dados há um administrador existente cujo login é:
```
email: admin@gamestream.com.br, senha: 123456
```
  * Usuários assinantes não há restrições e obrigatoriedade quanto aos domínios no momento do cadastro, em meio ao banco de dados há um assinante existente, cujo login é:
```
email: user@email.com, senha: 123456
```

Projeto final da turma 7 do [TreinaDev](https://treinadev.com.br/), realizado pela [Campus Code](https://www.campuscode.com.br/), com apoio das empresas [Rebase](https://www.rebase.com.br), [Konduto](https://www.konduto.com/), [Vindi](https://vindi.com.br/), [Portal Solar](https://www.portalsolar.com.br/) e [SmartFit](https://www.smartfit.com.br/).

Projeto desenvolvido por: [Daiane Souza](https://github.com/daiaventureira), [Hugo Araujo](https://github.com/oohugo), [Mateus Campos](https://github.com/mateusC2000), [Paulo Castellan Medeiros](https://github.com/paulo-castellan) e [Yan Donadi](https://github.com/Donads), juntamente com a equipe [Pagamentos Beta](https://github.com/TreinaDev/pagamentos-beta) integrada por: [Gabriel de Miranda](https://github.com/gabdemiranda), [Júlia Lopes](https://github.com/Omniabsent), [Renato Diniz](https://github.com/renatodinizc), [Rogerio A Serapiao](https://github.com/serapiaofranca).