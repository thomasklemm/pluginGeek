require 'spec_helper'

describe PagesController do
  it { should be_kind_of(HighVoltage::PagesController) }

  describe "#layout_for_page" do
    context "error 404" do
      it "selects error layout" do
        subject.params[:id] = '404'
        expect(controller.send(:layout_for_page)).to eq('errors')
      end
    end

    context "error 422" do
      it "selects error layout" do
        subject.params[:id] = '422'
        expect(controller.send(:layout_for_page)).to eq('errors')
      end
    end

    context "error 500" do
      it "selects error layout" do
        subject.params[:id] = '500'
        expect(controller.send(:layout_for_page)).to eq('errors')
      end
    end
  end
end
