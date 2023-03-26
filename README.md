# Solo Project: Restaurant Checkout

## 1. Description of the Problem
> As a customer  
> So that I can check if I want to order something  
> I would like to see a list of dishes with prices.
> 
> As a customer  
> So that I can order the meal I want  
> I would like to be able to select some number of several available dishes.
> 
> As a customer  
> So that I can verify that my order is correct  
> I would like to see an itemised receipt with a grand total.
> 
> As a customer  
> So that I am reassured that my order will be delivered on time  
> I would like to receive a text such as "Thank you! Your order was placed and
> will be delivered before 18:52" after I have ordered.


## 2. Class System Design

![Class System Design Drawing](docs/system_design.png?raw=true "System Design")


```ruby
class Menu
def initialize
end

def dishes(dish)
  #add dish to dishes
end

def all_available_dishes
  #return dishes avaiable 
end
end

class Dish
  def initialize(name, price)
  
end

def sold_out
#set avaiable to false
end

def is_avaiable
  #return true or false
end
end

class Order
  def initialize(menu, twillio_client)
  #arr dishes ordered
  end

  def add_dish(dish)
  #add dishes in your troller
  end

  def remove_dish(dish)
  #remove dishes in your troller
  end

  def grand_total
  #sum your order
  end

  def finish_order
  #when finished send message to client
  end
end

class TwillioClient
  def initialize(twillio_api)
  end
  
  def send_sms
  #send sms when client finished their order
  end
end
```
## 3. Integration Tests
_Create examples of the classes being used together in different situations and
combinations that reflect the ways in which the system will be used._
```ruby
# EXAMPLE

# Integration classes

###############
# Menu
###############

# gets all available dishes
dish_1 = Dish.new("Carbonara", 10.0)
dish_2 = Dish.new("Lasagna", 15.0)
dish_3 = Dish.new("Hamburguer", 9.0)
dish_4 = Dish.new("Fish and chips", 12.0)

dish_availability = DishAvailability.new([dish_1, dish_2, dish_4])

menu = Menu.new([dish_1, dish_2, dish_3, dish_4], dish_availability)
menu.all_available_dishes #=> [dish_1, dish_2, dish_4]

#return only one dish available
menu_2 = Menu.new([dish_1, dish_3], dish_availability)
menu_2.all_available_dishes #=> [dish_1]

###############
# Order
###############

#return total
dish_1 = Dish.new("Carbonara", 10.0)
dish_2 = Dish.new("Lasagna", 15.0)
dish_3 = Dish.new("Hamburguer", 9.0)

customer = Customer.new("John", "+447980752310")
order_1 = Order.new(customer)
order_1.add(dish_1)
order_1.add(dish_2)

order_1.grand_total #=> 25.0

# when I add a dish and them I remove the dish
dish_1 = Dish.new("Carbonara", 10.0)
dish_2 = Dish.new("Lasagna", 15.0)
dish_3 = Dish.new("Hamburguer", 9.0)

customer = Customer.new("John", "+447980752310")
order_1 = Order.new(customer)
order_1.add(dish_1)
order_1.add(dish_2)
order_1.remove(dish_1)

order_1.grand_total #=> 15.0

# raise error when try to remove item that it's not there
dish_1 = Dish.new("Carbonara", 10.0)
dish_2 = Dish.new("Lasagna", 15.0)
dish_3 = Dish.new("Hamburguer", 9.0)

customer = Customer.new("John", "+447980752310")
order_1 = Order.new(customer)
order_1.add(dish_1)
order_1.add(dish_2)
order_1.remove(dish_3) #=> raise error "Item is not in the order"


#return the finish order as a string and sms
dish_1 = Dish.new("Carbonara", 10.0)
dish_2 = Dish.new("Lasagna", 15.0)
dish_3 = Dish.new("Hamburguer", 9.0)

order_1 = Order.new(customer)
order_1.add(dish_1)
order_1.add(dish_2)

twillio = TwillioClient.new(requester_dbl, twillio_phone)

order_1.finish_order #=>"Thank you, #{name}! Your order was placed and will be delivered before 18:52"

```

## 4. Examples as Unit Tests

```ruby
# EXAMPLE
#return true for is_available
fake_1 = double :dish, name: "Hamburguer", price: 9.0
fake_2 = double :dish, name: "Carbonara", price: 10.0
dish_availability = DishAvailability.new([fake_1, fake_2]) 
dish_availability.is_available(fake_1) #=> true

#return false for is_available
fake_1 = double :dish, name: "Hamburguer", price: 9.0
fake_2 = double :dish, name: "Carbonara", price: 10.0
dish_availability = DishAvailability.new([fake_1]) 
dish_availability.is_available(fake_2) #=> false

#return false for is_available when dishavailabity is empty
fake_1 = double :dish, name: "Hamburguer", price: 9.0
fake_2 = double :dish, name: "Carbonara", price: 10.0
dish_availability = DishAvailability.new([]) 
dish_availability.is_available(fake_2) #=> false


# Menu unit test
# return menu all available dishes

fake_dish_1 = double :dish,  name: "Hamburguer", price: 9.0
fake_dish_2 = double :dish,  name: "Carbonara", price: 10.0
fake_dish_3 = double :dish,  name: "Lasagna", price: 15.0
fake_dish_4 = double :dish,  name: "Fish and chips", price: 11.0

fake_availability = double :dish_availability
expect(fake_availability).to reiceve(:is_available).with(fake_dish_1).and_return(true)
expect(fake_availability).to reiceve(:is_available).with(fake_dish_2).and_return(true)

menu = Menu.new([fake_dish_1,fake_dish_2,fake_dish_3,fake_dish_4], fake_availability)
menu.all_avaiable_dishes # => [fake_dish_1, fake_dish_2]

# Menu unit test
# one available and one not available  
fake_dish_1 = double :dish,  name: "Hamburguer", price: 9.0
fake_dish_2 = double :dish,  name: "Carbonara", price: 10.0
fake_dish_3 = double :dish,  name: "Lasagna", price: 15.0
fake_dish_4 = double :dish,  name: "Fish and chips", price: 11.0

fake_availability = double :dish_availability
expect(fake_availability).to reiceve(:is_available).with(fake_dish_3).and_return(false)
expect(fake_availability).to reiceve(:is_available).with(fake_dish_1).and_return(true)

menu = Menu.new([fake_dish_1,fake_dish_2,fake_dish_3,fake_dish_4], fake_availability)
menu.all_avaiable_dishes # => [fake_dish_1]


#Order unit test
phone = "+447980752310"
fake_customer = double :fake_customer, name: "Ana", phone: phone

twillio_fake = double :twillio_fake
success_msg = "Thank you, Ana! Your order was placed and will be delivered before 18:52"

expect(twillio_fake).to reiceve(:send_sms).with(success_msg, phone).and_return

order = Order(fake_customer)
fake_dish_1 = double :dish,  name: "Hamburguer", price: 9.0
fake_dish_2 = double :dish,  name: "Carbonara", price: 10.0

order.add(fake_dish_1)
order.add(fake_dish_2)
order.grand_total #=> 19.0

order.finish_order #=> success_msg

#
```

## 5. How to execute

In order for TwillioClient to work it is necessary to setup 
the following ENV variables:

```
export TWILIO_ACCOUNT_SID = YOUR_TWILLIO_ACCOUNT_SID
export TWILIO_AUTH_TOKEN = YOUR_TWILIO_AUTH_TOKEN
export REGISTERED_TWILLIO_PHONE = YOUR_REGISTERED_PHONE_NUMBER
```

* if you are using zsh as your shell script you need to add in `.zprofile`
* if you are using bash as your shell script you need to add in `.bash_profile`

```
$ ruby lib/restaurant_app.rb
```

## 6. Future improvement for app
• Error handler for not valid phone number.
• Create a receipt class responsible for formating the list of dishes ordered
• Create more tests raising errors
• Include others features: remove dish, print all ordered dishes on restaurant_app.rb
• Filter the user's choice on restaurant app from name to number (avoiding typos and other problems)
• Find another way to print objects in a more readble way without a method (Like overwriting toString() in Java) 
