#language: pt
@all
Funcionalidade: Tours CVC
  Validação de cenarios de testes top Tours

Contexto: 
  Dado que Eu esteja no site da CVC Viagens
  E que Eu esteja na Listagem de Circuitos

@set1
Esquema do Cenario: Tours Stress Test
  E seleciono "<leg>" e a origem como "<origem>" e o destino como "<destino>" em dia aleatorio
  # E seleciono voo "<tipo_de_voo>" para "<qt_adt>" adultos, "<qt_chd>" criancas e "<qt_inf>" bebes e clico em "Buscar"
  # Quando estou na pagina de resultados, seleciono a cia "<cia_aerea>" e clico em "Comprar"
  # E preencho os dados do check-out e uso um cartao "<cartao>" em "<numero_parcelas>"
  # # E espero que seja mostrada a tela de sucesso com o pedido

Exemplos:
  |tour          |qt_sr       |qt_adt     |qt_chd         |rom_sgl |rom_dbl|rom_tpl |start_nights|end_nights|
  |Lisboa        |65          |30         |com parada     |        |       |        |            |          |