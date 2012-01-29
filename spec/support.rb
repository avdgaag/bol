module SpecHelpers
  def fixture(name)
    File.read(File.expand_path(File.join('..', 'fixtures', name), __FILE__))
  end
end

