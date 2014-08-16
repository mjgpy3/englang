class Ancestory

  def initialize
    @ancestors = { type_thing: nil }
  end

  def provide_ancestor(child, parent)
    @ancestors[child] = parent
  end

  def in_ancestory?(child, parent)
    full_ancestory_from(child).include?(parent)
  end

  private

  def full_ancestory_from(child)
    ancestory = [child]
    while @ancestors.include?(child)
      ancestory << child = @ancestors[child]
    end
    ancestory
  end

end
