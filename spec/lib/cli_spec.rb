require 'webmeter/cli'

describe "Webmeter" do
  context "CLI" do
    it "should parse options" do
      cli = Webmeter::CLI.execute(["-a", "test.com"])
      cli.options.should == ["-a", "test.com"]
    end
  end
end
