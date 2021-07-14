require "./spec_helper"

it "returns all entries" do
  a = normalize_paths(Walk::Down.new("src"))
  b = normalize_paths(Dir.glob("src", "src/**/*"))

  a.should eq b
end

it "skips hidden files and directories" do
  a = normalize_paths(Walk::Down.new(".").filter { |path| !hidden_file?(path) })
  b = normalize_paths(Dir.glob(".", "**/*"))

  a.should eq b
end

it "finds Git root" do
  a = normalize_path(Walk::Up.new("src/walk.cr").find { |path| git_root?(path) }.as(Path))
  b = "."

  a.should eq b
end
