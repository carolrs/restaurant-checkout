class DishAvailability
  def initialize(available_dishes)
    @available_dishes = available_dishes
  end

  def is_available(dish)
    @available_dishes.include?(dish)
  end
end