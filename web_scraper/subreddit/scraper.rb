require "selenium-webdriver"
require 'uri'
require 'time'

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
    title = content.find_element(:css, ".y8HYJ-y_lTUHkQIc1mdCq._2INHSNB8V5eaWp4P0rY_mE > a").attribute("href")
    @links[title.to_sym] = 1 if title
  end
end

def main
  system('clear')
  driver = init_selenium_webdriver
  print "a subreddit to scrape: "
  subreddit = gets.strip.chomp
  url = "https://www.reddit.com/r/#{subreddit}/"
  mark = ['\\', '|' , '/', '|']

  #loop do
  navigate(driver, url)
  sleep(2)
  screen_height = driver.execute_script("return window.screen.height;")
  i=1

  while true
    driver.execute_script("window.scrollTo(0, #{screen_height*i});")  
    i+=1

    system('clear')
    print "...... scraping '/r/#{subreddit}' #{mark[i%4]}    "
    puts "#{((i/100.0)*100).round(2)}%"
    data = get_data(driver, {class_name: 'Post'})
    parse_data(data)
    break if i == 100
  end

  sleep 5

  driver.quit
end

main
File.open('output.dat', 'w') do |file|
  @links.each do |k, v|
    file.puts "link: #{k}"
  end
end 
