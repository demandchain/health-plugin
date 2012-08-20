require "spec_helper"

describe "HealthPlugin::Engine requests" do

  HealthPlugin.config do |config|
    config.mounts.each do |mount|
      config.checks.each do |check|

        uri = "/#{mount}/#{check}"
        header_tag = "#{config.prefix}-#{check.capitalize}"

        it "gets '#{uri}'" do
          get uri
          assert_response :success
        end

        it "supplies header '#{header_tag}' on get '#{uri}'" do
          get uri
          headers[header_tag].nil?.should_not be true
        end

        it "supplies content in header '#{header_tag}' on get '#{uri}'" do
          get uri
          headers[header_tag].blank?.should_not be true
          headers[header_tag].length.should be >= 1
        end

        it "supplied content in header '#{header_tag}' on get '#{uri}' which matches plugin defaults" do
          result = eval("HealthPlugin.#{check}")

          get uri
          headers[header_tag].should eq result.header
        end

      end
    end
  end

end
