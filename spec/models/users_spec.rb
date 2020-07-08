require 'rails_helper'

describe User do
  subject { User.new(name: name) }
  let(:name) { 'Franco' }
  
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(5) }
  it { should have_many(:votes) }
  it { should have_many(:articles).with_foreign_key(:author) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid with nil values' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid if user already exists' do
    User.create(name: name)
    expect(subject).to_not be_valid
  end
end
