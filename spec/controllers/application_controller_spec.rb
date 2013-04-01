require 'spec_helper'

describe ApplicationController do
  describe "#peek_enabled?" do
    let(:staff) { Fabricate(:user, staff: true) }

    context "development environment" do
      before { Rails.env = "development" }

      it "renders peek" do
        expect(Rails.env.development?).to be_true
        expect(controller.peek_enabled?).to be_true
      end
    end

    context "test environment" do
      before { Rails.env = "test" }

      it "doesn't render peek" do
        expect(Rails.env.test?).to be_true
        expect(controller.peek_enabled?).to be_false
      end
    end

    context "staging environment" do
      before { Rails.env = "staging" }

      it "doesn't render peek by default" do
        expect(Rails.env.staging?).to be_true
        expect(controller.peek_enabled?).to be_false
      end

      it "renders peek for staff" do
        sign_in staff
        expect(Rails.env.staging?).to be_true
        expect(controller.peek_enabled?).to be_true
      end
    end

    context "production environment" do
      before { Rails.env = "production" }

      it "doesn't render peek by default" do
        expect(Rails.env.production?).to be_true
        expect(controller.peek_enabled?).to be_false
      end

      it "renders peek for staff" do
        sign_in staff
        expect(Rails.env.production?).to be_true
        expect(controller.peek_enabled?).to be_true
      end
    end
  end
end
