require "spec"
require "../src/walk"

def hidden_file?(path)
  path.expand.basename.starts_with?('.')
end

def git_root?(path)
  Dir.exists?(path / ".git")
end

# Normalize results
def normalize_path(path)
  Path[path].normalize.to_s
end

def normalize_paths(paths)
  paths.map do |path|
    normalize_path(path)
  end.to_a.sort
end
