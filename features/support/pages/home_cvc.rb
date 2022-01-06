require 'capybara/dsl'

module Ng
    module HomeCVC

    include RSpec::Matchers
    include Capybara::DSL
#########start modules#########
    def check_basic_home
        assert_selector(EL['corona']['warning'], wait: 30)
        expect(page).to have_content(EL['header_text']['callcenter'], wait: 30)
        expect(page).to have_content(EL['header_text']['help'], wait: 30)

        #MICHEL
        assert_selector(EL['header_text']['signin_prod'], wait: 30)
        #expect(page).to have_content(EL['header_text']['signin_prod'], wait: 30)
    
        expect(page).to have_content(EL['header_menu']['text_air'], wait: 30)
        expect(page).to have_content(EL['header_menu']['text_hotel'], wait: 30)
        expect(page).to have_content(EL['header_menu']['text_package'], wait: 30)
        expect(page).to have_content(EL['header_menu']['text_disney'], wait: 30)
        #expect(page).to have_content(EL['header_menu']['text_tours'], wait: 30)    Não está mais no menu  #MICHEL #09/11/2021
        expect(page).to have_content(EL['header_menu']['text_plus'], wait: 30)
        expect(page).to have_content(EL['header_menu']['text_cvccard'], wait: 30)
    end

    def check_basic_home_tours
        expect(page).to have_css(EL['search_motor']['pesqinc'], wait: 30)
        expect(page).to have_content(EL['search_motor']['text_pesqinc'], wait: 30)
        expect(page).to have_css(EL['search_motor']['checkbox_multisearch'], wait: 30)
        expect(page).to have_content(EL['search_motor']['text_multisearch'], wait: 30)
        expect(page).to have_css(EL['search_motor']['calendar'], wait: 30)
        expect(page).to have_content(EL['search_motor']['text_btn_search'], wait: 30)
        # expect(page).to have_content('Buscar circuitos', wait: 30)
    end

    def fill_pesqinc
        # binding.pry
        tours = [
            'Lisboa', 
            'Berlin',
            'Madri',
            'Paris',
            'Roma',
            'Londres'
        ]
        $city = tours.sample
        find(EL['search_motor']['pesqinc'], wait: 30).click
        find(EL['search_motor']['input'], wait: 30).set($city)
        sleep 3 #MICHEL
        find(EL['search_motor']['choice'], wait: 30).click  #MICHEL
        expect(page).to have_css(EL['search_motor']['pesqinc'], text: $city)
        click_on('Buscar circuitos')
    end

    def fill_pesqinc_mobile
        # binding.pry
        tours = [
            'Lisboa', 
            'Berlin',
            'Madri',
            'Paris',
            'Roma',
            'Londres'
        ]
        $city = tours.sample
        find(EL['search_motor']['pesqinc'], wait: 30).click
        find(EL['search_motor']['input'], wait: 30).set($city)
        if $url == EL['url']['prod']
          find(:xpath, '/html/body/div[1]/div[3]/div[2]/div/div/div[2]/div/div[1]/div/div[1]/div/div[2]/div[2]/nav/div', wait: 10).click
        elsif $url == EL['url']['lo']
          find("span[class^='PesqincTour-content']", wait: 10).click
        end
        expect(page).to have_css(EL['search_motor']['pesqinc'], text: $city)

        if $url == EL['url']['prod']
            find(:xpath, EL['search_motor']['calendar_mobile'], wait: 30).click
        elsif $url == EL['url']['lo']
            find(:xpath, EL['search_motor']['calendar_mobile_lo'], wait: 30).click
        end
        expect(page).to have_css(EL['search_motor']['pick_date'],wait: 2)
        find(EL['search_motor']['pick_date'],wait: 30).click
        click_on('Buscar circuitos')
    end

#########end modules###########
    end#module HomeCVC
end#module ng