require 'ghost_to_jekyll/jekyll_formatter'

RSpec.describe GhostToJekyll::JekyllFormatter do
  let(:date) { '2020-02-08T20:11:51.000Z' }
  let(:slug) { 'this-is-a-very-good-blog-post' }

  subject { described_class.new(date: date, slug: slug) }

  it 'should return formatted post filename' do
    expect(subject.post_filename).to eq('2020-02-08-this-is-a-very-good-blog-post.md')
  end
end

