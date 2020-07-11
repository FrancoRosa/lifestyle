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
  it { should belong_to(:author) }
  it { should have_many(:votes) }
  it { should have_and_belong_to_many(:categories) }

  it 'is valid with valid attributes' do
    subject.image.attach(io: File.open(Rails.root.join('public', 'apple-touch-icon.png')),
                         filename: 'attachment.png',
                         content_type: 'image/png')
    expect(subject).to be_valid
  end

  it 'is not valid with nil values' do
    subject.title = nil
    subject.text = nil
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'is not if the title already exists' do
    Article.create(title: title, text: text, author: User.first)
    expect(subject).to_not be_valid
  end
end
