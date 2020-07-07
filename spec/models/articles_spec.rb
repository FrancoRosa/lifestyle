require 'rails_helper'

describe Article do
  subject { Article.new(title: title, text: text, author: User.first) }

  let!(:user) { User.create(name: name) }

  let(:name) { 'Franco' }

  let(:title) { 'Article Title' }
  let(:text) { 'Article text, about it' }
  let(:user_id) { user.id }

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least(5) }
  it { should validate_presence_of(:text) }
  it { should validate_length_of(:text).is_at_least(5) }
  it { should validate_presence_of(:author) }
  it { should belong_to(:user) }
  it { should have_many(:votes) }
  it { should have_many(:categories) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid with nil values' do
    subject.title = nil
    subject.place = nil
    subject.body = nil
    subject.place = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid if the title is not unique' do
    Event.create(title: 'Event Title', body: body, place: place, date: date, user_id: User.first.id)
    expect(subject).to_not be_valid
  end

  it 'is not valid if the title is not unique' do
    Event.create(title: 'Event 2 Title', body: body, place: place, date: date, user_id: User.first.id)
    expect(subject).to be_valid
  end
end
