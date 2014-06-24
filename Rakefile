require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

def subfolders; %w(Tests Example); end

def subperform(command)
  subfolders.each do |subfolder|
    Dir.chdir(subfolder) do
      sh "rake #{command}"
    end
  end
end

task :default => :test

task :ci => [:clobber, :test]

task :clobber do
  subperform(:clobber)
end

task :clean do
  subperform(:clean)
end

task :test => :spec do
  subperform(:test)

end

task :coverage do
  excludes = ['.*/Classes/.*\.h'] + subfolders.map { |subfolder| ".*/#{subfolder}/.*" }
  sh "coveralls #{excludes.map { |exclude| "-E '#{exclude}'" }.join(' ')}"
end
