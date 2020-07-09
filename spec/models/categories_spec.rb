require 'rails_helper'

describe Category do

  subject { Category.new(name: name, 
                        priority: priority) }
  let(:name) { 'MainCategory' }
  let(:priority) { 1 }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:priority) }
  it { should have_and_belong_to_many(:articles) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid with nil values' do
    subject.name = nil
    subject.priority = nil
    expect(subject).to_not be_valid
  end
end
