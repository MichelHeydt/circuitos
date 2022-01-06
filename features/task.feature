#language: pt
@task-0
Funcionalidade: Validate Tours CVC
  Validação de cenarios de testes top Tours

Contexto: 
  Dado que Eu esteja no site da CVC Viagens

@task-1_mobile
Cenario: Tours Check
  E que Eu esteja na home Tours mobile
  E pesquiso por algum lugar em modo mobile
  Entao verifico se a contagem de cidades confere em modo mobile
  