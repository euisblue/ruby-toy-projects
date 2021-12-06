require "selenium-webdriver"
require 'uri'

@links = Hash.new(0)

def init_selenium_webdriver
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  return Selenium::WebDriver.for :chrome, options: options
end

def navigate(driver, url)
  driver.navigate.to URI.join(url)
end

def get_data(driver, pattern)
  return driver.find_elements(pattern)
end

def parse_data(data)
  data.each do |content|
    color = content.text.split("\n")
    hex = color[1].split(' ')[1]
    puts "#{color[0]}  #{hex}"
    @links[color[0].to_sym] = hex if color
  end
end

def main
  driver = init_selenium_webdriver
  url = "https://www.color-meanings.com/shades-of-blue-color-names-html-hex-rgb-codes/"

  navigate(driver, url)
  data = get_data(driver, {class_name: 'has-text-color'})
  parse_data(data)

  driver.quit
end

main
File.open('output.dat', 'w') do |file|
  @links.each do |k, v|
    file.puts "#{k}, #{v}"
  end
end 
