class Menu
  def initialize(list_dishes, dish_availability)
    @list_dishes = list_dishes
    @dish_availability = dish_availability
  end
  def all_available_dishes
    @list_dishes.select {|dish| @dish_availability.is_available(dish)}
  end

  def all
    @list_dishes
  end
end