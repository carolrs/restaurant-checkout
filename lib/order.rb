require 'time'

class Order

  DELIVERY_TIME = 30 * 60 # 30 minutes in seconds

  def initialize(customer, twillio_client) 
    @customer = customer
    @twillio_client = twillio_client
    @ordered_dishes = []
  end

  def add(dish)
    @ordered_dishes << dish
    
  end

  def remove(dish)
    fail "Item is not in the order" if !@ordered_dishes.include?(dish)
    @ordered_dishes.delete(dish)

  end

  def print_ordered_dishes
    @ordered_dishes

  end
  
  def grand_total
    @ordered_dishes.map {|dish| dish.price }.sum

  end

  def finish_order(time)
    deliver_before = time + DELIVERY_TIME
    message = "Thank you, #{@customer.name}! Your order was placed, the total "
    .concat("is: #{grand_total} and will be delivered before #{deliver_before.strftime('%H:%M')}")

    @twillio_client.send_sms(message, @customer.phone)
    message
  end
end

# require 'twilio-ruby'
# require_relative './dish'
# require_relative './customer'
# require_relative './twillio_client'

# customer = Customer.new("Ana", "+447960854247")
# account_sid = ENV['TWILIO_ACCOUNT_SID']
# auth_token = ENV['TWILIO_AUTH_TOKEN']
# twillio_api = Twilio::REST::Client.new(account_sid, auth_token).messages

# client = TwillioClient.new(twillio_api)

# order = Order.new(customer, client)

# main_course = Dish.new("Carbonara", 15.5)
# dessert = Dish.new("Ice Cream", 5.5)

# order.add(main_course)
# order.add(dessert)

# puts "This is your grand total: #{order.grand_total}"

# puts order.finish_order(Time.now)