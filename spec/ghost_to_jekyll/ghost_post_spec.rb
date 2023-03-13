require 'ghost_to_jekyll/ghost_post'

RSpec.describe GhostToJekyll::GhostPost do
  let(:status) { 'published' }
  let(:post) {{
    :title => 'title',
    :published_at => 'published_at',
    :status => status,
    :slug => 'slug',
    :html => 'html'
  }}

  subject { described_class.new(post) }

  it 'returns post data' do
    expect(subject.title).to eq('title')
    expect(subject.published_at).to eq('published_at')
    expect(subject.status).to eq('published')
    expect(subject.slug).to eq('slug')
    expect(subject.html).to eq('html')
  end

  describe '#published?' do
    context 'when post status is published' do
      it 'returns true' do
        expect(subject.published?).to be true
      end
    end

    context 'when post status is draft' do
      let(:status) { 'draft' }

      it 'returns false' do
        expect(subject.published?).to be false
      end
    end
  end
end

