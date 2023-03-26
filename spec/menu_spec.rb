require 'menu'

describe Menu do
  context "#all_available" do
    it "return menu all available dishes" do
      fake_dish_1 = double :dish,  name: "Hamburguer", price: 9.0
      fake_dish_2 = double :dish,  name: "Carbonara", price: 10.0
      fake_dish_3 = double :dish,  name: "Lasagna", price: 15.0
      fake_dish_4 = double :dish,  name: "Fish and chips", price: 11.0

      fake_availability = double :dish_availability
      expect(fake_availability).to receive(:is_available).with(fake_dish_1).and_return(true)
      expect(fake_availability).to receive(:is_available).with(fake_dish_2).and_return(true)
      expect(fake_availability).to receive(:is_available).with(fake_dish_3).and_return(false)
      expect(fake_availability).to receive(:is_available).with(fake_dish_4).and_return(false)

      menu = Menu.new([fake_dish_1,fake_dish_2,fake_dish_3,fake_dish_4], fake_availability)
      expect(menu.all_available_dishes).to eq [fake_dish_1, fake_dish_2]

    end

    it "should return empty array when dish availability is all false" do
      fake_dish_1 = double :dish,  name: "Hamburguer", price: 9.0
      fake_dish_2 = double :dish,  name: "Carbonara", price: 10.0
      fake_dish_3 = double :dish,  name: "Lasagna", price: 15.0
      fake_dish_4 = double :dish,  name: "Fish and chips", price: 11.0

      fake_availability = double :dish_availability, is_available: false

      menu = Menu.new([fake_dish_1,fake_dish_2,fake_dish_3,fake_dish_4], fake_availability)
      expect(menu.all_available_dishes).to eq []

    end
  end
end