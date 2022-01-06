require 'capybara/dsl'

module Ng
  module WaitHelper

    include Capybara::DSL

#########start modules#########
    def wait_for_dom
      Capybara.default_max_wait_time = 40
      Timeout.timeout(Capybara.default_max_wait_time) do
      loop until page_has_loaded?
      end
    end
    
    def wait_for_ajax
      counter = 0
      while page.execute_script("return $.active").to_i > 0
       counter += 1
       sleep(0.1)
       raise "AJAX request took longer than 30 seconds." if counter >= 600
      end
    end

    def page_has_loaded?
       return page.evaluate_script('document.readyState;') == 'complete'
    end

    def page_has_loaded2?
      return Capybara.current_session.driver.execute_script('var browserState = document.readyState; return browserState;') == 'complete'
    end
    
    def wait_kit
       wait_for_dom
       wait_for_ajax
    end    

    def pagetime
      time1 = Time.now  
      timeloop = 0  
      while timeloop < 900  
        if (Capybara.current_session.driver.execute_script('var browserState = document.readyState; return browserState;') == 'complete')  
          time2 = Time.now  
          break  
        end  
        timeloop + 1  
      end  
      timeWait = (time2 - time1) * 1000  
      return timeWait  
    end

    def loadtime
      time1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)  
      timeloop = 0  
      while timeloop < 900  
        if (Capybara.current_session.driver.execute_script('var browserState = document.readyState; return browserState;') == 'complete')  
          time2 = Process.clock_gettime(Process::CLOCK_MONOTONIC)  
          break  
        end  
        timeloop + 1  
      end  
      # timeWait = (time2 - time1) * 1000  
      timeWait = time2 - time1
      return timeWait  
    end

    def wait_for_ajax2
      max_time = Capybara::Helpers.monotonic_time + Capybara.default_max_wait_time
      while Capybara::Helpers.monotonic_time < max_time
        finished = finished_all_ajax_requests?
        if finished
          break
        else
          sleep 0.1
        end
      end
      raise 'wait_for_ajax timeout' unless finished
    end
    
    
    def finished_all_ajax_requests?
      page.evaluate_script(<<~EOS
    ((typeof window.jQuery === 'undefined')
     || (typeof window.jQuery.active === 'undefined')
     || (window.jQuery.active === 0))
    && ((typeof window.injectedJQueryFromNode === 'undefined')
     || (typeof window.injectedJQueryFromNode.active === 'undefined')
     || (window.injectedJQueryFromNode.active === 0))
    && ((typeof window.httpClients === 'undefined')
     || (window.httpClients.every(function (client) { return (client.activeRequestCount === 0); })))
      EOS
      )
   end    

   def page_wait
      timeloop = 0

     while timeloop < 900  
        if (Capybara.current_session.driver.execute_script('var browserState = document.readyState; return browserState;') == 'complete') 
          break
        end
       timeloop += 1
     end
     puts "carregou"
   
   end

def timetest
  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
# time consuming operation
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  elapsed = ending - starting
return elapsed

end


#########end modules#########
  end#module waithelpers
end#module ng

