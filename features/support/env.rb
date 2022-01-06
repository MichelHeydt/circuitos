require 'rspec'
require 'yaml'
require 'pry'
require 'capybara/cucumber'
require 'capybara/poltergeist'

World(Capybara::DSL)

EL = YAML.load_file('data/el.yml')

$url = if ENV['prod']
  'https://www.cvc.com.br/'
elsif ENV['qa']
  'https://qa.cvc.com.br/'
elsif ENV['ti']
  'https://ti.cvc.com.br'
elsif ENV['lo']
  'http://local.cvc:3000/tours/'
end

$DEVICE = if ENV['S5']
  'Galaxy S5'
else
  'iPhone X'
end

# configuração dos navegadores
if ENV['sel']
  Capybara.javascript_driver = :selenium
  Capybara.default_driver = :selenium
  Capybara.register_driver(:selenium) do |app|
    options = Selenium::WebDriver::Chrome::Options.new(
      args: %w[--remote-debugging-port=9222 --incognito --disable-gpu --no-sandbox --disable-web-security]
  )
  # options.add_emulation(device_name: "#{$DEVICE}")
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    acceptInsecureCerts: true,
  )
  capabilities["browserName"] = "chrome"
  capabilities["version"] = "87.0"
  capabilities["enableVNC"] = true
  capabilities["enableVideo"] = true
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: "http://localhost:4444/wd/hub",
    options: options,
    desired_capabilities: capabilities
)
end
elsif ENV['chrome']
  Capybara.javascript_driver = :selenium
  Capybara.default_driver = :selenium
  Capybara.register_driver(:selenium) do |app|
    options = Selenium::WebDriver::Chrome::Options.new(
      args: %w[--incognito --disable-gpu --no-sandbox --disable-web-security --window-size=1024,768]
  )
  read_timeout = 400
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
  acceptInsecureCerts: true,
  )
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
    desired_capabilities: capabilities
  )
end
# elsif ENV['host']
#   Capybara.register_driver(:selenium) do |app|
#     options = Selenium::WebDriver::Chrome::Options.new(
#       args: %w[--incognito --disable-gpu --no-sandbox --disable-web-security]
#     )
#     options.add_emulation(device_name: 'Galaxy S5')
#     read_timeout = 400
#     capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
#       acceptInsecureCerts: true,
#     )
#     Capybara::Selenium::Driver.new(
#       app,
#       browser: :chrome,
#       options: options,
#       desired_capabilities: capabilities
#     )
# end
elsif ENV['chrome_headless']
  Capybara.javascript_driver = :selenium_chrome_headless
  Capybara.default_driver = :selenium_chrome_headless
  Capybara.register_driver(:selenium_chrome_headless) do |app|
    options = Selenium::WebDriver::Chrome::Options.new(
      args: %w[
        --headless 
        --incognito 
        --disable-gpu 
        --no-sandbox 
        --disable-setuid-sandbox 
        --disable-web-security 
        --window-size=1366,768
        --start-maximized
        --disable-infobars
        ]
  )
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.read_timeout = 240
  # read_timeout = 800
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    acceptInsecureCerts: true,
  )
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
    http_client: client,
    desired_capabilities: capabilities
  )
end
elsif ENV['chrome_mobile']
  Capybara.javascript_driver = :selenium
  Capybara.default_driver = :selenium
  Capybara.register_driver(:selenium) do |app|
    options = Selenium::WebDriver::Chrome::Options.new(
      args: %w[--incognito --disable-gpu --no-sandbox --disable-web-security]
  )
  options.add_emulation(device_name: "#{$DEVICE}")
  read_timeout = 400
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    acceptInsecureCerts: true,
  )
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
    desired_capabilities: capabilities
  )
end
elsif ENV['chrome_mobile_headless']
  Capybara.javascript_driver = :selenium
  Capybara.default_driver = :selenium
  Capybara.register_driver(:selenium) do |app|
    options = Selenium::WebDriver::Chrome::Options.new(
      args: %w[--headless --incognito --disable-gpu --no-sandbox --disable-web-security]
  )
  options.add_emulation(device_name: "#{$DEVICE}")
  read_timeout = 400
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    acceptInsecureCerts: true,
  )
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
    desired_capabilities: capabilities
  )
end
elsif ENV['chromium']
  Capybara.javascript_driver = :selenium
  Capybara.default_driver = :selenium
  Selenium::WebDriver::Chrome.path = '/usr/bin/chromium-browser'
  Capybara.register_driver(:selenium) do |app|
    options = Selenium::WebDriver::Chrome::Options.new(
      args: %w[--incognito --disable-gpu --no-sandbox --disable-web-security --window-size=1024,768]
  )
  read_timeout = 400
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    acceptInsecureCerts: true,
  )
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
    desired_capabilities: capabilities
  )
end
elsif ENV['chromium_headless']
  Capybara.javascript_driver = :selenium_chrome_headless
  Capybara.default_driver = :selenium_chrome_headless
  Selenium::WebDriver::Chrome.path = '/usr/bin/chromium-browser'
  Capybara.register_driver(:selenium_chrome_headless) do |app|
    options = Selenium::WebDriver::Chrome::Options.new(
    args: %w[
      --headless 
      --incognito 
      --disable-gpu 
      --no-sandbox 
      --disable-setuid-sandbox 
      --disable-web-security 
      --window-size=1366,768
      --start-maximized
      --disable-infobars
      ]
    )
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.read_timeout = 240
  # read_timeout = 800
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    acceptInsecureCerts: true,
  )
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
    http_client: client,
    desired_capabilities: capabilities
  )
end
else
  Capybara.default_driver = :selenium
end

#  Capybara.default_max_wait_time = 60