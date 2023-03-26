require 'twilio-ruby'
require_relative './dish'
require_relative './customer'
require_relative './twillio_client'
require_relative './order'
require_relative './dish_availability'
require_relative './menu'

#this class will simulate the front end. It will call order from here.
class RestaurantApp
  def initialize
    #I put everything here because I want to reuse the same values always. Probably it should be in a database
    dish_1 = Dish.new("Carbonara", 10.0)
    dish_2 = Dish.new("Lasagna", 15.0)
    dish_3 = Dish.new("Hamburguer", 9.0)
    dish_4 = Dish.new("Fish and chips", 11.0)
    dish_5 = Dish.new("Mince pie", 12.0)

    dish_list = [dish_1,dish_2,dish_3,dish_4,dish_5]

    dish_array_available = [dish_1,dish_2,dish_3]
    
    dish_availability =  DishAvailability.new(dish_array_available)
    
    @menu = Menu.new(dish_list, dish_availability)

  end

  def run 
    puts "Enter your name"
    name = gets.chomp
    puts "Enter your fone"
    phone = gets.chomp

    customer = Customer.new(name, phone)
    
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    twillio_phone = ENV['REGISTERED_TWILLIO_PHONE']
    twillio_api = Twilio::REST::Client.new(account_sid, auth_token).messages

    client = TwillioClient.new(twillio_api, twillio_phone)

    order = Order.new(customer, client)

    while true
      puts "Choose one of the options: "

      puts "[1] See the menu"
      puts "[2] See only the available options for the day"
      puts "[3] Add available dish to the cart"
      puts "[4] See grand total"
      puts "[5] finish order"
      puts "[6] exit"

      option = gets.chomp
      
      case option
        when "1" then format_all_dishes(@menu.all)
        when "2" then format_all_dishes(@menu.all_available_dishes)
        when "3" then add_dish(order)
        when "4" then puts "Total so far #{order.grand_total}"
        when "5" then puts order.finish_order(Time.now) 
        when "6" then exit
      end
      if option == "5"
        break
      end
      puts " "
    end
  end

  def format_dish(dish)
    return dish.name + " - " + dish.price.to_s
  end

  def format_all_dishes(dishes)
    dishes.each do |dish|
      puts format_dish(dish)
    end
  end

  def add_dish(order)
    puts "Type the name of your dish"
    name_dish = gets.chomp
    dish = get_dish_by_name(name_dish)
    order.add(dish)
  end

  def get_dish_by_name(name)
      dish_arr = @menu.all_available_dishes.select { |dish|
          dish.name == name
      }
      #return the first position of the array because the select it will return an new array but I only want one dish
      return dish_arr.first
  end
end

RestaurantApp.new.run