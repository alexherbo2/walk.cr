class Walk::Down
  # Iterator
  include Iterator(Path)

  # Properties
  property root : Path
  property current : Path?
  property stack : Array(Path)

  # Creates iterator.
  def initialize(path : Path)
    @root = path
    @current = path
    @stack = [] of Path
  end

  def self.new(path : String)
    new(Path[path])
  end

  # Rewinds iterator.
  def rewind
    @current = @root
    @stack.clear

    self
  end

  # Returns the next element.
  def next
    entry = @current

    case entry
    when Path
      # Push directory entries into the stack
      if File.directory?(entry)
        # Build paths.
        entries = Dir.children(entry).map do |child|
          entry / child
        end

        @stack.concat(entries)
      end

      # Update the current element for the next iteration.
      # Can be nil to signal that there are no more elements.
      @current = @stack.pop?

      entry
    else
      stop
    end
  end

  # Skips entry.
  # Similar to `next` without descending into directories.
  def skip
    if @current
      @current = @stack.pop?
    else
      stop
    end
  end

  # Returns an iterator for pruning the entries in the directory tree.
  def filter(&predicate : Path -> Bool)
    Filter(self).new(self, &predicate)
  end
end

require "./down/filter"
