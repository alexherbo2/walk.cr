# walk.cr

walk.cr is a [Crystal] library for walking a directory recursively.
Comes with support for top-down and bottom-up traversal, and mechanisms for pruning the entries in the directory tree.

[Crystal]: https://crystal-lang.org

## Dependencies

- [Crystal]

## Installation

1. Add the dependency to your `shard.yml`:

``` yaml
dependencies:
  walk:
    github: alexherbo2/walk.cr
```

2. Run `shards install`.

## Usage

**Example** – Recursively iterate over the given directory and print the path for each entry:

``` crystal
require "walk"

Walk::Down.new("src").each do |path|
  puts path
end
```

Output example:

```
src
src/walk
src/walk/down.cr
src/walk/up.cr
src/walk.cr
```

**Example** – Skip hidden files and directories:

``` crystal
require "walk"

def hidden_file?(path)
  path.expand.basename.starts_with?('.')
end

Walk::Down.new(".")

.filter do |path|
  !hidden_file?(path)
end

.each do |path|
  puts path
end
```

Output example:

```
.
README.md
shard.yml
spec
spec/walk_spec.cr
src
src/walk.cr
```

**Example** – Find Git root:

``` crystal
require "walk"

def git_root?(path)
  Dir.exists?(path / ".git")
end

Walk::Up.new("src/walk.cr").find do |path|
  git_root?(path)
end
```

Result example:

``` crystal
Path["."]
```

See the [source] for a complete reference.

[Source]: src

## Credits

- [walkdir]

[walkdir]: https://github.com/BurntSushi/walkdir
