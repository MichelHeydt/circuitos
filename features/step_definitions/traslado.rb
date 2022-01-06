Dado('que eu selecione um circuito que possua apenas transfer in') do
    visit($url+'/tours/detail/20397-alma-europeia-clasica?startDate=2022-03-01')
end

Quando('selecione uma data da viagem') do
   expect(page).to have_content('Escolha as datas')
   $pickDay = rand(0..all('.dayPrice').count)
   all('.dayPrice')[$pickDay].click
end

Quando('selecione Não vou usar traslado') do
    all('.MuiIconButton-label', wait: 10)[2].click
end

Quando('selecione Ainda nao comprei um voo') do
    all('.MuiIconButton-label', wait: 10)[1].click
end

Quando('selecione Já tenho um voo') do
    all('.MuiIconButton-label', wait: 10)[0].click
end

Quando('preencha os quatro campos obrigatórios') do
    all('.jss448', wait: 30)[1].set 'Aeroporto'
    all('.jss448', wait: 30)[2].set 'Companhia'
    all('.jss448', wait: 30)[3].set '737'
    all('.jss448', wait: 10)[4].set $date
end

Quando('eu clicar no botão Confirmar') do
    click_on('Confirmar')[0]
end

Quando('eu clicar no botão Sem alterações') do
    find('.applyChangesBtn', wait: 10).click
    assert_no_selector('.MuiCircularProgress-svg', wait: 100)
end

Então('deve habilitar o botão Reserve agora') do
    expect(page).to have_button('Reserve agora', disabled: false)
    sleep 3
end