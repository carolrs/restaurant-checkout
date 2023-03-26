require 'menu'
require 'dish'
require 'dish_availability'

describe Menu do
  context"#all_availables" do
    it "returns all availables dishes" do
      dish_1 = Dish.new("Carbonara", 10.0)
      dish_2 = Dish.new("Lasagna", 15.0)
      dish_3 = Dish.new("Hamburguer", 9.0)
      dish_4 = Dish.new("Fish and chips", 12.0)

      dish_availability = DishAvailability.new([dish_1, dish_2, dish_4])

      menu = Menu.new([dish_1, dish_2, dish_3, dish_4], dish_availability)
      expect(menu.all_available_dishes).to eq [dish_1, dish_2, dish_4]

    end

    it "returns only one dish available" do
      dish_1 = Dish.new("Carbonara", 10.0)
      dish_2 = Dish.new("Lasagna", 15.0)

      dish_availability = DishAvailability.new([dish_1])

      menu = Menu.new([dish_1, dish_2], dish_availability)

      expect(menu.all_available_dishes).to eq  [dish_1]

    end

    it "when no dishes available" do
      dish_1 = Dish.new("Carbonara", 10.0)
      dish_2 = Dish.new("Lasagna", 15.0)

      dish_availability = DishAvailability.new([])

      menu = Menu.new([dish_1, dish_2], dish_availability)

      expect(menu.all_available_dishes).to eq  []

    end
  end
end