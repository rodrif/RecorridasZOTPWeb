# require 'rubygems'
#   require 'selenium-webdriver'
#
#   Given(/^I am on the login page$/) do
#     @driver = Selenium::WebDriver.for :firefox
#     @driver.get "localhost:3000"
#   end
#
#   When(/^I login with an existent user$/) do
#     user = @driver.find_element(name: "user[email]")
#     user.send_keys "admin@gmail.com"
#     pass = @driver.find_element(name: "user[password]")
#     pass.send_keys "123456789"
#     @driver.button.click
#   end
#
#   Then(/^I get access to the Home Page$/) do
#     wait = Selenium::WebDriver::Wait.new(timeout: 10)
#     wait.until { @driver.find_element(:id, "googleMap") }
#     @driver.close
#   end