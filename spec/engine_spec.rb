require 'spec_helper'

module Mappable
  describe Engine do
    it "should preload map routes when it starts" do
      Mappable::MapRouter.expects(:build_map_routes!)

      ActionDispatch::Reloader.prepare!
    end
  end
end
