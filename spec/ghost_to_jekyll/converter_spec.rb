require 'ghost_to_jekyll/converter'

RSpec.describe GhostToJekyll::Converter do
  let(:html) { '<h3>Paint selection</h3>' }
  let(:post_title) { 'This is an Art Attack' }

  subject { described_class.new(html: html, post_title: post_title) }

  it 'converts html to jekyll formatted kramdown' do
    expect(subject.convert).to eq("---\ntitle: This is an Art Attack\n---\n\n### Paint selection\n\n")
  end
end

