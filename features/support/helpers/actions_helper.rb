require 'capybara/dsl'
require 'uri'
require 'net/http'
require 'slack-notifier'
require 'rubygems'
require 'zip'

module Ng
    module ActionsHelper

      include Capybara::DSL
#########start modules#########

      def notify_slack(message, channel = '#status_tours')
        url              = "https://hooks.slack.com/services/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"
        uri              = URI.parse(url)
        http             = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl     = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request          = Net::HTTP::Post.new(uri.request_uri)
        request.body     = {"text"=>"#{message}"}.to_json
        response         = http.request(request)
      end
   
      #status_tours
      def slack
        Slack::Notifier.new "https://hooks.slack.com/services/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" do
          defaults channel: "#status_tours",
                   username: "Hades"
        end
      end

      def zipzip
        folder = "output/reports/"
        input_filenames = ['report.html', 'report.json']
    
        zipfile_name = "report.zip"
    
        Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
            input_filenames.each do |filename|
                zipfile.add(filename, File.join(folder, filename))
            end
        end
    end

      def focus_browser
        result = page.driver.browser.window_handles.last
        page.driver.browser.switch_to.window(result)
      end

      def slack_error_msg
        bubbles = ["seus otarios", "seus sacos de lixo", "seus abestados", "seus digníssimos imbecis", "seus sofá de zona", "seus manés"]
        bubbles2 = [
          "Falha na Matrix", 
          "Um erro ocorreu ao mostrar o erro anterior", 
          "O teclado não está respondendo. Aperte qualquer tecla para continuar.", 
          "Nenhum erro ocorreu.", 
          "Falha catastrófica." ,
          "Errar é humano, persistir no erro é bug!", 
          "Existem apenas 10 tipos de pessoas neste mundo: as que entendem códigos binários e as que não entendem!"
        ]
        Ng.slack.ping "```
          
        TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR
        TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR

                                                  @ @ @ @ @  #{$date}  @ @ @ @ @
        
        #{bubbles2.sample} 

        

        TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR
        TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR-TOURS_ERROR
        
        ```"
        Ng.iupi
      end

      def iupi
        `curl -F file=@report.zip -F "initial_comment=#{$date}" -F channels=C01SZK4NTCK -H "Authorization: Bearer xoxb-5113372510-1925795064694-n63OS308aXJefbqAO6GIjCtx" https://slack.com/api/files.upload`
      end

      def close_tab
        result = page.driver.browser.window_handles.last
        page.driver.browser.switch_to.window(result)
        page.driver.browser.close
      end

      def closeNewTabs
        window = page.driver.browser.window_handles
        if window.size > 1 
          page.driver.browser.switch_to.window(window.last)
          page.driver.browser.close
          page.driver.browser.switch_to.window(window.first)
          end
      end

      # Scroll to any element/section
      # @param element [Capybara::Node::Element, SitePrism::Section]
      def scroll_to(element)
        element = element.root_element if element.respond_to?(:root_element)
        Capybara.evaluate_script <<-EOS
          function() {
            var element = document.evaluate('#{element.path}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
            window.scrollTo(0, element.getBoundingClientRect().top + pageYOffset - 200);
          }();
        EOS
      end
      
      # click on locator using java script
      def java_script_click_to(element)
        element = element.root_element if element.respond_to?(:root_element)
        Capybara.evaluate_script <<-EOS
          function() {
            var element = document.evaluate('#{element.path}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
            element.click();
          }();
        EOS
      end
  
      # scroll into view
      def scrollIntoView(element)
        page.execute_script("$('#{element}').get(0).scrollIntoView();")
        Ng.wait_for_ajax
      end
  
      # Click by point coordinates
      # @param x [Integer]
      # @param y [Integer]
      def click_by_coordinates(x, y)
        Capybara.execute_script("document.elementFromPoint(#{x}, #{y}).click()")
      end
  
      # Refresh page
      def refresh_page
        Capybara.page.driver.browser.navigate.refresh
      end
  
      # Mouse hover element/section
      def hover_over(element)
        element = element.root_element if element.respond_to?(:root_element)
        Capybara.page.driver.browser.action.move_to(element.native).perform
      end
  
      # coose value from dropdown list
      # usage : Ng.choose_from_drop_down(PROPERTY_TYPE,FLATS)
      def choose_from_drop_down(locator, value, type='css')
        find(type.to_sym, locator).find(:option, "#{value}").select_option
        Ng.wait_for_ajax
      end
  
      # click on a link within a wrapper
      def click_link_within(wrapper, link)
        within(wrapper) do
          find(:link, link).click
        end
      end
  
      # type text
      def type_text(locator, input_text, type='css')
        find(type.to_sym, locator).set input_text
        Ng.wait_for_ajax
      end
  
      #click on within
      def click_on_within(tree_head_locator, locator, type='css')
        within(tree_head_locator) do
          find(type.to_sym, locator).click
        end
      end
  
      # click on xpath by indenting
      def click_on_using_indentation(xpath, indentation_value)
        find(:xpath, "#{xpath}#{indentation_value}']").click
      end
  
      # hover item within wrapper
      def hover_within(wrapper, locator, type)
        within(wrapper) do
          find(type.to_sym, locator).hover
        end
      end
  
      # click on any text
      def click_on_text(text_to_click)
        find(:xpath, "//*[contains(text(),'#{text_to_click}')]").click
      end
  
      # click on label for
      def click_on_label_for(label)
        find(:xpath, "//label[@for='#{label}']").click
      end
  
      # choose random value from a drop down
      def choose_random_option_from_drop_down(type, locator)
        options = find(type, locator).all(:option)
        if options.last.text.include? 'My address is not listed'
          tmp_options = options.drop(1)
          # remove my address is not listed option
          tmp_options2 = tmp_options.first options.size - 1
          # select from what is left
          tmp_options2[rand(tmp_options2.count)].select_option
        elsif options.count <= 2
          options[1].select_option
        else
          tmp_options3 = options.drop(1)
          tmp_options3[rand(tmp_options3.count)].select_option
        end
      end
  
      def save_cookies
        cookies = Capybara.page.driver.browser.manage.all_cookies.to_yaml
        File.open(shared_path + '/cookies.yml', 'w') { |f| f.write cookies }
      end
  
      def delete_all_cookies
        Capybara.page.driver.browser.manage.delete_all_cookies
      end
  
      def populate_cookies
        cookies = YAML.load(File.open(shared_path + '/cookies.yml'))
        cookies.each { |cookie| Capybara.page.driver.browser.manage.add_cookie cookie }
      end

    #verifica se há modal do marketing
    # if has_selector?('.socl-open.socl-center', wait: 10) do
    #   within_frame('social-onsite') do
    #     find('.close').click
    #   end
    # end
  
      def shared_path
        if File.directory?('/dev/shm')
          '/dev/shm'
        else
          FileUtils.mkdir_p('output/config') unless File.exists?('output/config')
          'output/config'
        end
      end
  
      private :shared_path



#########end modules#########
    end#module actionhelper
  end#module ng
  