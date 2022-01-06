Dado('verifico a home da CVC') do
    #binding.pry
    Ng.check_basic_home
    find(EL['header_menu']['air'], wait: 2).click
end

Dado('que Eu esteja na home Tours') do 
    visit($url+'tours')
end

Dado('verifico a home de Tours e pesquiso por algum lugar') do
    Ng.check_basic_home
    Ng.check_basic_home_tours
    Ng.fill_pesqinc
end

Dado('verifico a pagina de listagem e escolho um circuito') do
    $random = rand(0..9)
    raise "Não foi possível carregar o circuito!" if page.has_content?("Não foi possível carregar o circuito!")
    
    page.has_content?(EL['listing']['warning'], wait: 60)
    all(EL['listing']['card'], wait: 2).count == 10
    all('#cityrate', text: 'Cidades visitadas', wait: 2).count == 10
    all('#viewmore', text: 'Ver itinerário', wait: 2).count == 10
    all('#totalpeople', text: '1 Viajante em quarto duplo', wait: 2).count == 10
    all('#btndetail', text: 'Ver Detalhes', wait: 2).count == 10
    all('#amenities', text: 'Parcelamento Disponível', wait: 2).count == 10
    $tours_name = all('#tourname', wait: 5).map(&:text)
    $tours_price = all('#pricecontainer', wait:2).map(&:text)
    $var = $tours_name.zip $tours_price
    # $var.each do |x|
    #     Ng.slack.ping "``` #{x} ```"
    # end
    all('#btndetail', text: 'Ver Detalhes', wait: 2)[$random].click
    # Ng.slack.ping "``` Circuito escolhido na primeira pagina da listagem: #{$tours_name[$random]} ```"
    Ng.focus_browser
end

Dado('verifico a pagina de detalhes e reservo um circuito') do
   raise "Não foi possível carregar o circuito!" if page.has_content?("Não foi possível carregar o circuito!")

   assert_selector('.btn-add-room', wait: 60)
   expect(page).to have_content('Seu Circuito', wait: 60)
   expect(page).to have_button('Reserve agora', disabled: true)
   expect(page).to have_content($tours_name[$random])
   expect(page).to have_content('Sua viagem detalhada dia a dia', wait: 60)
   expect(page).to have_content('Tipos de quarto e quantidade de passageiros', wait: 60)
   expect(page).to have_content('Data da viagem', wait: 60)
   expect(page).to have_content('Categorias', wait: 60)
   expect(page).to have_content('Resumo do circuito', wait: 60)
   expect(page).to have_content('Tipos de quarto e quantidade de passageiros', wait: 60)
   all('.btn-add-room', wait: 1)[0].click
   expect(page).to have_content('Passageiro 1', wait: 60)

   all('.jss448', wait: 10)[0].set '26/03/1991' #MICHEL
   expect(page).to have_content('Aplicar', wait: 60)
   click_on('Aplicar') 

   assert_no_selector('.MuiCircularProgress-svg', wait: 100)
   expect(page).to have_content('Aplicar')
   assert_no_selector('.MuiCircularProgress-svg', wait: 100)
   expect(page).to have_content('Escolha as datas')
   $pickDay = rand(0..all('.dayPrice').count)
   all('.dayPrice')[$pickDay].click
   assert_no_selector('.MuiCircularProgress-svg', wait: 100)
   expect(page).to have_content('Os preços podem variar de acordo com a disponibilidade.')
   all('.selectBtn', wait:2)[0].click
   expect(page).to have_css('.selectBtn', text: 'Selecionado', wait:10)
   click_on('Hoteis previstos')
   all('.MuiSvgIcon-root', wait: 15)[0].click    #MICHEL
   all('.addNight', wait: 10)[0].click
   expect(all('.nightCount', wait: 10)[0].text == "1").to eq true
   all('.addNight', wait: 10)[1].click
   expect(all('.nightCount', wait: 10)[1].text == "1").to eq true
   find('.applyChangesBtn', wait: 10).click
   assert_no_selector('.MuiCircularProgress-svg', wait: 100)
   
    if page.has_text?('Traslado')  
        expect(page).to have_button('Reserve agora', disabled: true)   
        if page.has_text?('Volta')
            all('.MuiIconButton-label', wait: 10)[2].click  #seleciona 'Não vou usar o traslado'
            click_on('Confirmar')[0]  #Confirmar transfer in
            expect(page).to have_button('Reserve agora', disabled: true)
            all('.MuiIconButton-label', wait: 10)[5].click  #seleciona 'Não vou usar o traslado'
            all('.MuiButton-contained.MuiButton-containedPrimary', wait: 10)[4].click   #Confirmar transfer out
            expect(page).to have_button('Reserve agora', disabled: false) #deve habilitar o botão de Reserve agora
        else
            all('.MuiIconButton-label', wait: 10)[2].click  #seleciona 'Não vou usar o traslado'
            click_on('Confirmar')[0]
            expect(page).to have_button('Reserve agora', disabled: false)  #deve habilitar o botão de Reserve agora
        end
    end

   expect(page).to have_button('Reserve agora')
   click_on('Reserve agora')
   expect(page).to have_content('Formulário de Reserva', wait: 10)
   expect(page).to have_content('Precisamos de alguns dados para que um vendedor possa contatá-lo e finalizar sua reserva', wait:10)
end

Entao('envio o resultado no canal do slack') do
    # Ng.slack.ping "``` 
    # #{$text2}
    # #{$text1} 

    # ***** Circuitos encontrados na listagem para #{$city}: *****
    
    # ***** Teste Finalizado *****
    # ```"
end