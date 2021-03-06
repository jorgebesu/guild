require 'rails_helper'

RSpec.describe Job, :type => :model do
  context 'New' do
    let!(:job) { Job.new }

    it 'should generate new instance' do
      expect(job).to be_a(Job)
    end

    it 'archived boolean should be false' do
      expect(job.archived).to eq false
    end
  end

  context 'archive!' do
    let!(:job) { create :job }

    it 'archive!, archives a job' do
      expect { job.archive! }.to change { job.archived? }.from(false).to(true)
    end
  end

  context 'Expired' do
    before :each do
      FactoryGirl.create_list(:job, 2)
      FactoryGirl.create_list(:job, 3, :expired)
      FactoryGirl.create_list(:job, 4, :expired, archived: true)
    end

    it 'returns only expired jobs' do
      expect(Job.expired.count).to eq 3
    end

    it 'does not return archived jobs' do
      expect(Job.expired.count).to eq 3
    end
  end

  context 'Destroy' do
    let!(:job) { create :job }

    it 'should destroy the record' do
      expect { job.destroy! }.to change { Job.count }.by(-1)
    end
  end
end
