require 'webmeter/cli'

describe "Webmeter" do
  context "CLI" do
    it "should parse options" do
      cli = Webmeter::CLI.execute(["--all"])
      cli.options.should == ["--all"]
    end
  end
end
