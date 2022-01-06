Dado('que Eu esteja no site da CVC Viagens') do
    visit($url)
    timewait2 = Ng.loadtime
    $text1 = p "HOME CVC | PAGELOAD TIME: #{timewait2} seconds"
    $text2 = p "TESTE INICIADO EM #{$date}"
end

# mobile
Dado('que Eu esteja na home Tours mobile') do
    if $url == EL['url']['prod']
       expect(page).to have_content('A viagem dos seus sonhos começa na CVC', wait: 60)
       find('[aria-controls="simple-menu"]', wait: 1).click
       find('a[href="/tours"]').click
       expect(page).to have_content(EL['welcome_text']['tours'], wait: 60)
    elsif $url == EL['url']['lo']
       expect(page).to have_content(EL['welcome_text']['tours'], wait: 60)
    end
end

# mobile
Dado('pesquiso por algum lugar em modo mobile') do
   Ng.fill_pesqinc_mobile
end

# mobile
Dado('verifico se a contagem de cidades confere em modo mobile') do
   page.has_content?(EL['listing']['warning'], wait: 60)
   ary = []
   $random = rand(0..9)
   $city_count = all('#cityrate', wait: 1)[$random].text.to_i
   all('#cityrate', wait: 10)[$random].click
   ary = find('#cityexp', wait: 10).text.split('>')
   if ary.count == $city_count
      log 'Contagem de cidades visitadas confere'
   else
      log 'Contagem de cidades visitadas nao confere'
   end
end
