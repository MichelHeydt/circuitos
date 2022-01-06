#language: pt
@000
Funcionalidade: Validate Tours CVC
  Validação de cenarios de testes top Tours

Contexto: 
  Dado que Eu esteja no site da CVC Viagens
  

@001
Cenario: CVC Home Check
  E verifico a home da CVC
  Entao envio o resultado no canal do slack


@tourscheck
Cenario: Tours Check
  E que Eu esteja na home Tours
  E verifico a home de Tours e pesquiso por algum lugar
  E verifico a pagina de listagem e escolho um circuito
  E verifico a pagina de detalhes e reservo um circuito
  Entao envio o resultado no canal do slack