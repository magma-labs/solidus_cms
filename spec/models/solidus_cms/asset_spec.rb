# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusCms::Asset, type: :model do
  describe "after commit" do
    let(:subject) { SolidusCms::Asset.create! }

    context "when attachment_file_size has changed" do
      before do
        allow(subject).to receive(:previous_changes) { { attachment_file_size: [1, 2] } }
      end

      it "enqueues a job to reprocess the attachment" do
        expect(SolidusCms::PaperclipReprocessJob).to receive(:perform_later).once.with(
          subject,
          :attachment
        )

        subject.update! updated_at: Time.now
      end
    end
  end
end
