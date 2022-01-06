require 'selenium-webdriver'
require 'report_builder'
require 'rspec/expectations'
require 'rspec/retry'

ReportBuilder.configure do |config|
# config.input_path = 'output/reports/report.json'
config.json_path = 'output/reports/report.json'
config.report_path = 'output/reports/report'
config.report_types = [:html, :retry]
# config.report_tabs = [:overview, :features, :scenarios, :errors]
config.report_title = 'Report Tours CVC'
config.include_images = true
config.color = 'cyan'
#   if $url == EL['url']['prod']
#     $env = "Producao"
#   elsif $url == EL['url']['hmg']
#     $env = "Homologacao"
#   else
#     $env = 'Producao'
#   end
#   config.additional_info = {browser: 'Chrome', environment: $env}
end

RSpec.configure do |config|
   config.verbose_retry = true
   config.default_retry_count = 2
   config.exceptions_to_retry = [Net::ReadTimeout]
end

Before do
   $date = Time.now.strftime('%d-%m-%Y/%H:%M')
   include RSpec::Matchers
   Capybara.reset_sessions!
   page.driver.browser.manage.window.resize_to(1366, 768)
   page.driver.browser.manage.window.maximize
end

After do |scenario|
   if scenario.failed?
      dat = Time.now.strftime("%H-%M-%S")
      Dir::mkdir('output', 0777) if not File.directory?('output')
      Dir::mkdir('output/screenshots', 0777) if not File.directory?('output/screenshots')
      Dir::mkdir('output/reports', 0777) if not File.directory?('output/reports')
      screenshot = "./output/screenshots/FAILED_#{scenario.name.gsub(' ', '_').gsub(/[^0-9A-Za-z_]/, '')}_#{dat}.png"
      if page.driver.browser.respond_to?(:save_screenshot) then
         page.driver.browser.save_screenshot(screenshot)
         else
         save_screenshot(screenshot)
      end
      FileUtils.chmod(0777, screenshot)
      attach(current_url, 'text/plain')
      attach(screenshot, 'image/png')
      # Ng.zipzip
      # Ng.slack_error_msg
   end 
      Capybara.current_session.driver.browser.manage.delete_all_cookies
      Capybara.current_session.driver.quit  
end

at_exit do
   ReportBuilder.build_report
end
