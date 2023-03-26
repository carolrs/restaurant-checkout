require 'order'
require 'time'

describe Order do
  context "#add" do
    it "should print all dishes added" do
    
      fake_customer = double :fake_customer
      sms_sender_fake = double :twillio_fake
    
      order = Order.new(fake_customer, sms_sender_fake)
      fake_dish_1 = double :dish,  name: "Hamburguer", price: 9.0
      fake_dish_2 = double :dish,  name: "Carbonara", price: 10.0

      order.add(fake_dish_1)
      order.add(fake_dish_2)
      expect(order.print_ordered_dishes).to eq [fake_dish_1, fake_dish_2]
    end
  end

  context "#remove" do
    it "should remove dishes from order" do
    
      fake_customer = double :fake_customer
      sms_sender_fake = double :twillio_fake
    
      order = Order.new(fake_customer, sms_sender_fake)
      fake_dish_1 = double :dish,  name: "Hamburguer", price: 9.0
      fake_dish_2 = double :dish,  name: "Carbonara", price: 10.0

      order.add(fake_dish_1)
      order.add(fake_dish_2)
      order.remove(fake_dish_1)
      expect(order.print_ordered_dishes).to eq [fake_dish_2]
    end
  end

  context "#grand_total" do
    it "should return the sum of all dishes added" do
      phone = "+447980752310"
      fake_customer = double :fake_customer, name: "Ana", phone: phone

      sms_sender_fake = double :twillio_fake
      #success_msg = "Thank you, Ana! Your order was placed and will be delivered before 18:52"

      #expect(sms_sender_fake).to receive(:send_sms).with(success_msg, phone).and_return

      order = Order.new(fake_customer, sms_sender_fake)
      fake_dish_1 = double :dish,  name: "Hamburguer", price: 9.0
      fake_dish_2 = double :dish,  name: "Carbonara", price: 10.0

      order.add(fake_dish_1)
      order.add(fake_dish_2)
      expect(order.grand_total).to eq 19.0
    end
  end

  context "#finish_order" do
    it "should return the sum of all dishes added" do
      #static time
      time = Time.new(2000,11,11,18,52)
      phone = "+447980752310"
      fake_customer = double :fake_customer, name: "Ana", phone: phone

      sms_sender_fake = double :twillio_fake
      #it will return 19:22 because is time + 30 min
      success_msg = "Thank you, Ana! Your order was placed, the total is: 19.0 and will be delivered before 19:22"

      expect(sms_sender_fake).to receive(:send_sms).with(success_msg, phone).and_return("12345")

      order = Order.new(fake_customer, sms_sender_fake)
      fake_dish_1 = double :dish,  name: "Hamburguer", price: 9.0
      fake_dish_2 = double :dish,  name: "Carbonara", price: 10.0

      order.add(fake_dish_1)
      order.add(fake_dish_2)
      order.grand_total

      expect(order.finish_order(time)).to eq success_msg
    end
  end
end