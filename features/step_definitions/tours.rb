Dado('que Eu esteja na Listagem de Circuitos') do
    visit('https://www.cvc.com.br/tours/search?date=2023-03&zoneIds=34301')
    expect(page).to have_content('Atenção!', wait: 30)
    expect(page).to have_button('Ver Detalhes', wait: 30)
    page.has_button?('Ver Detalhes')
    page.has_content?('Atenção!')
    page.has_css?('div', text: 'Agora Europa +i')
end

# Dado('') do

# end

# Dado('') do

# end