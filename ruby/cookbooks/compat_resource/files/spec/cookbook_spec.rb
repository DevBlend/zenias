require 'tmpdir'
require 'chef/version'

describe "compat_resource cookbook" do
  let(:chef_repo_path) { Dir.mktmpdir }
  let(:cookbooks_path) { path = File.join(chef_repo_path, 'cookbooks'); Dir.mkdir(path); path }
  before do
    File.symlink(File.expand_path('../data/config.rb', __FILE__),
                 File.join(chef_repo_path, 'config.rb'))
    File.symlink(File.expand_path('../../..', __FILE__),
                 File.join(cookbooks_path, 'compat_resource'))
    File.symlink(File.expand_path('../data/cookbooks/test', __FILE__),
                 File.join(cookbooks_path, 'test'))
    File.symlink(File.expand_path('../data/cookbooks/future', __FILE__),
                 File.join(cookbooks_path, 'future'))
    File.symlink(File.expand_path('../data/cookbooks/normal', __FILE__),
                 File.join(cookbooks_path, 'normal'))
    File.symlink(File.expand_path('../data/cookbooks/hybrid', __FILE__),
                 File.join(cookbooks_path, 'hybrid'))
    File.symlink(File.expand_path('../data/cookbooks/notifications', __FILE__),
                 File.join(cookbooks_path, 'notifications'))
    File.symlink(File.expand_path('../data/cookbooks/cloning', __FILE__),
                 File.join(cookbooks_path, 'cloning'))
  end

  require 'chef/mixin/shell_out'
  include Chef::Mixin::ShellOut
  before :all do
    FileUtils.rm_f(File.expand_path('../data/Gemfile.lock', __FILE__))
    Bundler.with_clean_env do
      shell_out!("bundle install --gemfile #{File.expand_path('../data/Gemfile', __FILE__)}")
    end
  end

  def run_chef(args)
    Bundler.with_clean_env do
      shell_out!("bundle exec chef-client -c #{File.join(chef_repo_path, 'config.rb')} -F doc #{args}",
                 environment: { 'BUNDLE_GEMFILE' => File.expand_path('../data/Gemfile', __FILE__) })
    end
  end

  it "should handle new-style recursive notifications" do
    result = run_chef("-o notifications")
    puts result.stdout
    puts result.stderr
  end

  it "should not clone resources from the outer run context" do
    result = run_chef("-o future::declare_resource,cloning::default")
    expect(result.stdout).not_to match(/3694/)
  end

  it "when chef-client runs the test recipe, it succeeds" do
    result = run_chef("-o test::test,test")
    puts result.stdout
    puts result.stderr
#     expect(result.stdout).to match(/
# Recipe: test::test
#   \* future_resource\[sets neither x nor y\] action create \(up to date\)
#   \* future_resource\[sets both x and y\] action create
#     - update sets both x and y
#     -   set x to "hi" \(was "initial_x"\)
#     -   set y to 10 \(was 2\)
#   \* future_resource\[sets neither x nor y explicitly\] action create \(up to date\)
#   \* future_resource\[sets only y\] action create
#     - update sets only y
#     -   set y to 20 (was 10)
#   \* future_resource\[deletes resource\] action delete \(up to date\)
#   \* future_resource\[sets x and y via creation\] action create
#     - create sets x and y via creation
#     -   set x to "hi"
#     -   set y to 20
#   \* future_resource\[deletes resource again\] action delete \(up to date\)
#   \* future_resource\[sets x and y to their defaults via creation\] action create
#     - create sets x and y to their defaults via creation
#     -   set x to "16" \(default value\)
#     -   set y to 4 \(default value\)
# /)
  end
  if Gem::Requirement.new("< 12.6").satisfied_by?(Gem::Version.new(Chef::VERSION))
    it "when chef-client tries to declare_resource with extra parameters, it fails" do
      expect {
        run_chef("-o normal::declare_resource")
      }.to raise_error(Mixlib::ShellOut::ShellCommandFailed)
    end
  end
end
