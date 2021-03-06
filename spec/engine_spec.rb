require 'spec_helper'

module Mappable
  describe Engine do
    before do
      clear_kernel_method :LegacyAccountName
      clear_kernel_method :CurrentAccountName
    end
    
    it "should preload map routes when it starts" do
      Mappable::Map.create!(subject: 'account', attr: 'name', from: 'legacy', to: 'current')
      ActionDispatch::Reloader.prepare!

      Kernel.respond_to?(:LegacyAccountName).should be_true
      Kernel.respond_to?(:CurrentAccountName).should be_true
    end
  end
end
