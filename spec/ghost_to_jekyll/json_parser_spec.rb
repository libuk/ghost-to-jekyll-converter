require 'ghost_to_jekyll/json_parser'
require 'json'

RSpec.describe GhostToJekyll::JSONParser do
  let(:file_path) { '/path/to/file' }

  subject { described_class.new(file_path) }

  context 'when file does not exist' do
    it 'should raise exception' do
      allow(File).to receive(:exists?).with(file_path).and_return(false)

      expect { subject.parse! }.to raise_error(IOError)
    end
  end

  context 'when parsing JSON fails' do
    let(:file) { double({ read: 'file-contents' }) }

    it 'should raise exception' do
      allow(File).to receive(:exists?).with(file_path).and_return(true)
      allow(File).to receive(:open).with(file_path).and_return(file)
      allow(JSON).to receive(:parse).with(file.read, symbolize_names: true).and_raise(JSON::ParserError)

      expect { subject.parse! }.to raise_error(JSON::ParserError)
    end
  end

  context 'when parsing JSON succeeds' do
    let(:file) { double({ read: 'file-contents' }) }
    let(:parsed_json) { '{"data": "file-contents"}' }

    it 'should return parsed JSON' do
      allow(File).to receive(:exists?).with(file_path).and_return(true)
      allow(File).to receive(:open).with(file_path).and_return(file)
      allow(JSON).to receive(:parse).with(file.read, symbolize_names: true).and_return(parsed_json)

      expect(subject.parse!).to eq(parsed_json)
    end
  end
end

