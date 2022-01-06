#language: pt
@traslado
Funcionalidade: Validação de cenários de traslado
  Validar as funcionalidades de traslado

Contexto: 
  Dado que Eu esteja no site da CVC Viagens
  E que Eu esteja na home Tours
  
@transferin_radio_nao_vou_usar_traslado
Cenario: Habilitar botão Reserve agora, radio Não vou usar traslado
Dado que eu selecione um circuito que possua apenas transfer in 
Quando eu selecionar o quarto individual
E preencher a data de nascimento
E clicar em Aplicar
E selecione uma data da viagem
E eu clicar no botão Sem alterações
E selecione Não vou usar traslado
E eu clicar no botão Confirmar
Então deve habilitar o botão Reserve agora

@transferin_radio_ainda_nao_comprei_um_voo
Cenario: Habilitar botão Reserve agora, radio Eu ainda não comprei um voo
Dado que eu selecione um circuito que possua apenas transfer in 
Quando eu selecionar o quarto individual
E preencher a data de nascimento
E clicar em Aplicar
E selecione uma data da viagem
E eu clicar no botão Sem alterações
E selecione Ainda nao comprei um voo
E eu clicar no botão Confirmar
Então deve habilitar o botão Reserve agora

@transferin_radio_ja_tenho_um_voo
Cenario: Habilitar botão Reserve agora, radio Eu já tenho um voo
Dado que eu selecione um circuito que possua apenas transfer in 
Quando eu selecionar o quarto individual
E preencher a data de nascimento
E clicar em Aplicar
E selecione uma data da viagem
E eu clicar no botão Sem alterações
E selecione Já tenho um voo
E preencha os quatro campos obrigatórios
E eu clicar no botão Confirmar
Então deve habilitar o botão Reserve agora