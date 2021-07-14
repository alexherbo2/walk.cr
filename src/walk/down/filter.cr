class Walk::Down::Filter(T)
  # Iterator
  include Iterator(Path)

  # Wraps iterator
  include Iterator::IteratorWrapper

  macro wrapped_skip
    value = @iterator.skip

    return stop if value.is_a?(Stop)

    self.next
  end

  # Properties
  property iterator : T
  property predicate : Path -> Bool

  def initialize(@iterator : T, &@predicate : Path -> Bool)
  end

  # Rewinds iterator.
  def rewind
    @iterator.rewind

    self
  end

  # Returns the next element.
  #
  # Yields only entries which satisfy the given predicate and skips
  # descending into directories that do not satisfy the given predicate.
  #
  # The predicate is applied to all entries.
  # If the predicate is true, iteration carries on as normal.
  # If the predicate is false, the entry is ignored and if it is a directory,
  # it is not descended into.
  def next
    entry = @iterator.current

    case entry
    when Path
      if @predicate.call(entry)
        wrapped_next
      else
        wrapped_skip
      end
    else
      stop
    end
  end
end
