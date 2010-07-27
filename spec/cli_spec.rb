require 'webmeter/cli'

describe Webmeter do
  it "should parse options" do
    cli = Webmeter::CLI.execute(["--all"])
    cli.options.should == ["--all"]
  end
end