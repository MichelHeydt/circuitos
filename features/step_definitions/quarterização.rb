#step definitions referente aos bugs https://cvccorp.atlassian.net/browse/TMTCCI-157 e https://cvccorp.atlassian.net/browse/TMTCCI-158
Quando('eu selecionar o quarto individual') do
    expect(page).to have_content('Tipos de quarto e quantidade de passageiros', wait: 60)
    all('.btn-add-room', wait: 1)[0].click
end

Quando('eu selecionar o quarto Duplo') do
    all('.btn-add-room', wait: 5)[1].click
end

Quando('preencher a data de nascimento') do
    all('.jss448', wait: 10)[0].set '26/03/1991'
    sleep 1
end

Quando('clicar em Aplicar') do
    click_on('Aplicar')
end

Quando('logo em seguida clicar em Limpar') do
    click_on('Limpar')
end

Quando('preencher os dados dos passageiros') do
    all('.jss448', wait: 10)[0].set '26/03/1991'
    all('.jss448', wait: 10)[1].set '26/03/1988'
end

Então('deve carregar o calendário sem ocorrer erro algum') do
    expect(page).to have_text("Escolha as datas", wait: 10)
end

Entao('o botao Aplicar deve ficar desabilitado') do
    expect(page).to have_button('Aplicar', disabled: true)
end

Entao('o label crianca deve ser exibido') do
    expect(page).to have_content('Criança', wait: 10)
end

Quando('preencher os dados do quarto com {int} pax de menor') do |int|
    if (int == 1)
        all('.jss448', wait: 10)[0].set '26/03/2016'
    elsif (int == 2) 
        all('.jss448', wait: 10)[0].set '26/03/2017'
        all('.jss448', wait: 10)[1].set '26/03/2017'
    else
        all('.jss448', wait: 10)[0].set '26/03/2018'
        all('.jss448', wait: 10)[1].set '26/03/2018'
        all('.jss448', wait: 10)[2].set '26/03/2018'
    end
end

Quando('eu selecionar o quarto Triplo') do
    all('.btn-add-room', wait: 5)[2].click
end

Quando('eu remover o quarto individual') do
    all('.btn-remove-room', wait: 1)[0].click  
end

Quando('eu remover o quarto duplo') do
    all('.btn-remove-room', wait: 1)[1].click
end

Então('deve exibir mensagem que menor não pode ficar em quarto sozinho') do
    expect(page).to have_text("Menores de 18 anos não podem estar em quartos sozinhos", wait: 10)
end

Então('o botao Aplicar deve ficar habilitado') do
    expect(page).to have_button('Aplicar', disabled: false)
end

Quando('preencher os dados do quarto com um pax de menor e um pax de maior') do
    all('.jss448', wait: 10)[0].set '26/03/2017'
    all('.jss448', wait: 10)[1].set '26/03/1991'
end

Quando('preencher os dados do quarto com dois pax de menor e um pax de maior') do
    all('.jss448', wait: 10)[0].set '26/03/2018'
    all('.jss448', wait: 10)[1].set '26/03/2020'
    all('.jss448', wait: 10)[2].set '26/03/1991'
end