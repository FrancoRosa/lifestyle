require 'rails_helper'

describe Vote do
  subject { Vote.new() }

  let(:author) { User.create(name: "user") }
  
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:article) }

  it 'is valid with valid attributes' do
    a = Article.new(title: "title", 
                    text: "text", 
                    author: author)

    a.image.attach(io: File.open(Rails.root.join('public','apple-touch-icon.png')),
            filename: 'attachment.png', 
            content_type: 'image/png')  
    a.save
    subject.user = author
    subject.article = Article.first
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
