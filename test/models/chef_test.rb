require 'test_helper'

class ChefTest < ActiveSupport::TestCase
    
    def setup
        @chef =  Chef.new(chefname: "poop", email: "poop@example.com")
    end
    test "chef object should be valid" do
        assert @chef.valid?
    end
    test "chefname should be present" do
        @chef.chefname = " "
        assert_not @chef.valid?
    end
    test "chefname lenght should not be too long" do
        @chef.chefname = "a"*41
        assert_not @chef.valid?
    end
    test "chefname lenght should not be too short" do
        @chef.chefname = "aa"
        assert_not @chef.valid?
    end
    test "email should be present" do
        @chef.email = " "
        assert_not @chef.valid?
    end
    test "email lenght should be within bounds" do
        @chef.email = "a"*101 + "@example.com"
        assert_not @chef.valid?
    end
    test "email address should be unique" do
        dup_chef = @chef.dup
        dup_chef.email = @chef.email.upcase
        @chef.save
        assert_not dup_chef.valid?
    end
    test "email address should accept valid address" do
        valid_addresses = %w[user@eee.com user@example.com first.last@boob.com mom+pop@family.com]
        valid_addresses.each do |va|
            @chef.email = va
            assert @chef.valid?, "#{va.inspect} should be valid"
        end
    end
    test "email address should reject invalid address" do
        invalid_addresses = %w[user@eee,com user.example.com first.last@boob+.com mom+pop@family.]
        invalid_addresses.each do |ia|
            @chef.email = ia
            assert_not @chef.valid?, "#{ia.inspect} is invalid"
        end
    end
end

    
    