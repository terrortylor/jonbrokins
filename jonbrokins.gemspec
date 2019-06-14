
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jonbrokins/version"

Gem::Specification.new do |spec|
  spec.name          = "jonbrokins"
  spec.version       = Jonbrokins::VERSION
  spec.authors       = ["Alex Tylor"]

  spec.summary       = %q{Tool to query multiple Jenkins instances}
  spec.description   = %q{Pool the state of jobs in multiple Jenkins instances, and check console output from the comfort of your termial.}
  spec.homepage      = "https://github.com/terrortylor/jonbrokins"
  spec.license       = "MIT"

  spec.files = Dir.glob('{bin,lib}/**/*', File::FNM_DOTMATCH)
  spec.bindir        = 'bin'
  spec.executables   = ["jonbrokins"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
