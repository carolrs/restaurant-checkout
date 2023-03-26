require 'time'

class Order

  DELIVERY_TIME = 30 * 60 # 30 minutes in seconds

  #I used sms as parameter because I wanted to make it easy to test.Otherwise would be difficult to mock
  def initialize(customer, sms_sender) 
    @customer = customer
    @sms_sender = sms_sender
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

    @sms_sender.send_sms(message, @customer.phone)
    message
  end
end

