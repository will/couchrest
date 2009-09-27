require File.expand_path("../../../spec_helper", __FILE__)

describe "ExtendedDocument", "no declerations" do
  class NoProtection < CouchRest::ExtendedDocument
    use_database TEST_SERVER.default_database
		property :name
		property :phone
	end

  it "should not protect anything through new" do
    user = NoProtection.new(:name => "will", :phone => "555-5555")

		user.name.should == "will"
		user.phone.should == "555-5555"
	end

  it "should not protect anything through attributes=" do
    user = NoProtection.new
		user.attributes = {:name => "will", :phone => "555-5555"}

		user.name.should == "will"
		user.phone.should == "555-5555"
	end
end

describe "ExtendedDocument", "accessable flag" do
  class WithAccessable < CouchRest::ExtendedDocument
    use_database TEST_SERVER.default_database
		property :name, :accessable => true
		property :admin, :default => false
	end

	it "should recoginze accessable properties" do
    props = WithAccessable.accessable_properties.map { |prop| prop.name}
		props.should include("name")
		props.should_not include("admin")
	end

	it "should protect non-accessable properties set through new" do
    user = WithAccessable.new(:name => "will", :admin => true) 

		user.name.should == "will"
		user.admin.should == false
	end

	it "should protect non-accessable properties set through attributes=" do
    user = WithAccessable.new
		user.attributes = {:name => "will", :admin => true}

		user.name.should == "will"
		user.admin.should == false
	end
end

describe "ExtendedDocument", "protected flag" do
  class WithProtected < CouchRest::ExtendedDocument
    use_database TEST_SERVER.default_database
		property :name
		property :admin, :default => false, :protected => true
	end

	it "should recoginze protected properties" do
    props = WithProtected.protected_properties.map { |prop| prop.name}
		props.should_not include("name")
		props.should include("admin")
	end

	it "should protect non-accessable properties set through new" do
    user = WithProtected.new(:name => "will", :admin => true) 

		user.name.should == "will"
		user.admin.should == false
	end

	it "should protect non-accessable properties set through attributes=" do
    user = WithProtected.new
		user.attributes = {:name => "will", :admin => true}

		user.name.should == "will"
		user.admin.should == false
	end
end
