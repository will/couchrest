require File.expand_path("../../../spec_helper", __FILE__)

describe "ExtendedDocument" do
  class WithAccessable< CouchRest::ExtendedDocument
    use_database TEST_SERVER.default_database
		property :name, :accessable => true
		property :admin, :default => false
	end

	it "should not allow non accessable set through new" do
    user = WithAccessable.new(:name => "will", :admin => true) 

		user.name.should == "will"
		user.admin.should == false
	end

	it "should not allow non accessable set through attributes=" do
    user = WithAccessable.new
		user.attributes = {:name => "will", :admin => true}

		user.name.should == "will"
		user.admin.should == false
	end
end
