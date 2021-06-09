require "test_helper"

describe "Rails command" do
  before do
    @runner = RailsNewApp::Runner.new
    @runner.config[:app_name] = "TestApp"
  end

  it "sets the database" do
    %w[mysql postgresql].each do |db|
      @runner.config[:database] = {key: db, in_rails_new: true}
      cmnd = @runner.build_rails_new_command

      assert_equal "rails new --database=#{db} TestApp", cmnd
    end
  end

  it "skips tests if not 'minitest'" do
    ["", "rspec"].each do |option|
      @runner.config[:test_runner] = {key: option}
      cmnd = @runner.build_rails_new_command

      assert_equal "rails new --skip-test TestApp", cmnd
    end

    @runner.config[:test_runner] = {key: "minitest"}
    cmnd = @runner.build_rails_new_command

    assert_equal "rails new TestApp", cmnd
  end

  it "calls the rails new command at the end" do
    fake = Minitest::Mock.new
    fake.expect :call, nil, ["rails new TestApp"]
    @runner.stub :run_cmnd, fake do
      capture_io do
        @runner.rails_new
      end
    end

    fake.verify
  end
end
