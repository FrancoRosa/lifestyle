require 'rails_helper'

describe Vote do
  subject { Vote.new() }

  let!(:user) { User.create(name: "my_user") }
  let(:article) { Article.new(title: "title", text: "text text", author: User.first, image: nil)}
  let(:article1) { Article.new(title: "title1", text: "text text", author: User.first, image: nil)}
  
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:article) }

  it 'is valid with valid attributes' do
    article.image.attach(io: File.open(Rails.root.join('public','apple-touch-icon.png')),
                         filename: 'attachment.png', 
                         content_type: 'image/png')
    article.save
    subject.user = user
    subject.article = article
    expect(subject).to be_valid
  end

  it 'is not valid with nil values' do
    subject.user = nil
    subject.article = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid if user already voted before' do
    article.image.attach(io: File.open(Rails.root.join('public','apple-touch-icon.png')),
                         filename: 'attachment.png', 
                         content_type: 'image/png')

    a = Vote.new(user_id: user.id, article_id: article.id)
    subject.article = article
    expect(subject).to_not be_valid
  end
end
