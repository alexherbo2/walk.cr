class Walk::Up
  # Iterator
  include Iterator(Path)

  # Properties
  property root : Path
  property current : Path

  # Creates iterator.
  def initialize(path : Path)
    @root = path
    @current = path
  end

  def self.new(path : String)
    new(Path[path])
  end

  # Rewinds iterator.
  def rewind
    @current = @root

    self
  end

  # Returns the next element.
  def next
    entry = @current

    if entry.expand == Path["/"]
      stop
    else
      @current = entry.join("..").normalize

      entry
    end
  end
end
