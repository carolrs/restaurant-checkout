require 'order'
require 'dish'
require 'customer'
require 'twillio_client'

describe Order do
  context "#grand_total" do
    it "return the total" do
      dish_1 = Dish.new("Carbonara", 10.0)
      dish_2 = Dish.new("Lasagna", 15.0)

      customer = Customer.new("John", "+447980752310")
      order_1 = Order.new(customer,nil)
      order_1.add(dish_1)
      order_1.add(dish_2)
     
      expect(order_1.grand_total).to eq 25.0
    end

    it "return the total only considering the dishes in the basket" do
      dish_1 = Dish.new("Carbonara", 10.0)
      dish_2 = Dish.new("Lasagna", 15.0)
    
      customer = Customer.new("John", "+447980752310")
      order_1 = Order.new(customer,nil)

      order_1.add(dish_1)
      order_1.add(dish_2)
      order_1.remove(dish_1)
     
      expect(order_1.grand_total).to eq 15.0
    end

    it "raises error when try to remove item non existent" do
      dish_1 = Dish.new("Carbonara", 10.0)
      dish_2 = Dish.new("Lasagna", 15.0)
    
      customer = Customer.new("John", "+447980752310")
      order_1 = Order.new(customer,nil)
      order_1.add(dish_1)

      expect { order_1.remove(dish_2) }.to raise_error "Item is not in the order"
    end
  end

  context "#finish_order" do
    it "return the finish order as a string and sms" do

      dish_1 = Dish.new("Carbonara", 10.0)
      dish_2 = Dish.new("Lasagna", 15.0)
    
      customer = Customer.new("John", "+447999999999")

      #mocking Twilio::REST::Client
      fake_twillio_api = double :requester

      time = Time.now
      expected_time = time + (30 * 60)
      body = "Thank you, John! Your order was placed, the total is: 25.0 and will be delivered before #{expected_time.strftime('%H:%M')}"
      twillio_fone = "+447700153097"

      #I'm expecting to receive an OBJ with a method sid with should have my protocol
      expected_response_from_twillio_api = double :response_message, sid: "some sid"

      #mocking twillio API (Twilio::REST::Client.new(account_sid, auth_token).messages.create)
      expect(fake_twillio_api).to receive(:create)
        .with(body: body, from: twillio_fone, to: customer.phone)
        .and_return(expected_response_from_twillio_api)
  
        twillio = TwillioClient.new(fake_twillio_api, twillio_fone)

        order_1 = Order.new(customer, twillio)
        order_1.add(dish_1)
        order_1.add(dish_2)

        expect(order_1.finish_order(time)).to eq "Thank you, John! Your order was placed, the total is: 25.0 and will be delivered before #{expected_time.strftime('%H:%M')}"
    end
  end
end