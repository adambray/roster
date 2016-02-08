class Roster
  def initialize
    @students = []
  end

  def add(student)
    return false unless student.class == Student

    @students << student
    return true
  end

  def students(sort_options = {})
    verify_sort_options(sort_options)

    # This approach is complex, but I can't find a simpler way of doing it.
    # It relies on ruby's built in sort method's ability to sort by an array
    # of properties. The trick is reversing which sort array the property goes
    # in depending on whether you want to sort the field asc or desc.
    @students.sort do |a,b|
      left, right = [], []
      sort_options.each_pair do |key, value|
        if value == :asc
          left << a.send(key); right << b.send(key)
        else
          left << b.send(key); right << a.send(key)
        end
      end
      left <=> right
    end
  end

  private
  def verify_sort_options(sort_options)
    sort_options.keys.each do |key|
      raise ArgumentError unless Student::ATTRS.include?(key)
    end

    sort_options.values.each do |value|
      raise ArgumentError unless [:asc, :desc].include?(value)
    end

  end
end
