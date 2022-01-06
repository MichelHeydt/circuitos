#language: pt
#feature referente aos bugs https://cvccorp.atlassian.net/browse/TMTCCI-157 e https://cvccorp.atlassian.net/browse/TMTCCI-158
@quarterizacao
Funcionalidade: Validação erro ao trocar quarto selecionado
  Validação erro ao trocar quarto selecionado

Contexto: 
  Dado que Eu esteja no site da CVC Viagens
  E que Eu esteja na home Tours
  E verifico a home de Tours e pesquiso por algum lugar
  E verifico a pagina de listagem e escolho um circuito

@bloqueiomenor
Cenario: Validação bloqueio com menor de 18 anos BUG 158
    Quando eu selecionar o quarto individual
    E preencher os dados do quarto com 1 pax de menor
    Então o botao Aplicar deve ficar desabilitado
    E deve exibir mensagem que menor não pode ficar em quarto sozinho
    E o label crianca deve ser exibido
    Quando eu remover o quarto individual 
    E eu selecionar o quarto Duplo
    E preencher os dados do quarto com 2 pax de menor
    Então o botao Aplicar deve ficar desabilitado
    E deve exibir mensagem que menor não pode ficar em quarto sozinho
    Quando eu remover o quarto duplo 
    E eu selecionar o quarto Triplo
    E preencher os dados do quarto com 3 pax de menor
    Então o botao Aplicar deve ficar desabilitado
    E deve exibir mensagem que menor não pode ficar em quarto sozinho

@quartocommaioredemenor
Cenario: Validação libera quarto com menor e maior juntos BUG 158
    Quando eu selecionar o quarto Duplo
    E preencher os dados do quarto com um pax de menor e um pax de maior
    Então o botao Aplicar deve ficar habilitado
    Quando eu remover o quarto duplo
    E eu selecionar o quarto Triplo
    E preencher os dados do quarto com dois pax de menor e um pax de maior
    Então o botao Aplicar deve ficar habilitado

@errotrocarquarto
Cenario: Validação erro ao trocar quarto selecionado BUG 157
    Quando eu selecionar o quarto individual
    E preencher a data de nascimento
    E clicar em Aplicar
    Então deve carregar o calendário sem ocorrer erro algum
    Quando logo em seguida clicar em Limpar
    E eu selecionar o quarto Duplo
    E preencher os dados dos passageiros
    E clicar em Aplicar
    Então deve carregar o calendário sem ocorrer erro algum


