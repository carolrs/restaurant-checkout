require 'dish_availability'

describe DishAvailability do
    it "should return true for is_available" do 
      fake_1 = double :dish, name: "Hamburguer", price: 9.0
      fake_2 = double :dish, name: "Carbonara", price: 10.0
      dish_availability = DishAvailability.new([fake_1, fake_2]) 
      expect(dish_availability.is_available(fake_1)).to eq true
    end

    it "should return false for is_available" do 
      fake_1 = double :dish, name: "Hamburguer", price: 9.0
      fake_2 = double :dish, name: "Carbonara", price: 10.0
      dish_availability = DishAvailability.new([fake_1]) 
      expect(dish_availability.is_available(fake_2)).to eq false
    end

    it "return false for is_available when dish availabity is empty" do 
      fake_2 = double :dish, name: "Carbonara", price: 10.0
      dish_availability = DishAvailability.new([]) 
      expect(dish_availability.is_available(fake_2)).to eq false
    end
end