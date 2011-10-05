require 'spec_helper'

describe 'mappable:views' do
  context "with no arguments or options" do
    it "should copy all the views" do
      subject.should generate 'app/views/mappable'

      subject.should generate 'app/views/mappable/mappings'
      subject.should generate 'app/views/mappable/mappings/_form.html.erb'
      subject.should generate 'app/views/mappable/mappings/edit.html.erb'
      subject.should generate 'app/views/mappable/mappings/index.html.erb'
      subject.should generate 'app/views/mappable/mappings/new.html.erb'
      subject.should generate 'app/views/mappable/mappings/show.html.erb'

      subject.should generate 'app/views/mappable/maps'
      subject.should generate 'app/views/mappable/maps/_form.html.erb'
      subject.should generate 'app/views/mappable/maps/edit.html.erb'
      subject.should generate 'app/views/mappable/maps/index.html.erb'
      subject.should generate 'app/views/mappable/maps/new.html.erb'
      subject.should generate 'app/views/mappable/maps/show.html.erb'
    end
  end

  context "with a map name argument" do
    with_args "foo_names" do
      it "should copy all the views into a scope directory named after the map specified" do
        subject.should generate 'app/views/mappable/foo_names/mappings'

        subject.should generate 'app/views/mappable/foo_names/mappings'
        subject.should generate 'app/views/mappable/foo_names/mappings/_form.html.erb'
        subject.should generate 'app/views/mappable/foo_names/mappings/edit.html.erb'
        subject.should generate 'app/views/mappable/foo_names/mappings/index.html.erb'
        subject.should generate 'app/views/mappable/foo_names/mappings/new.html.erb'
        subject.should generate 'app/views/mappable/foo_names/mappings/show.html.erb'
      end

      it "should not generate scoped map views" do
        subject.should_not generate 'app/views/mappable/foo_names/maps'
      end
    end
  end
end
