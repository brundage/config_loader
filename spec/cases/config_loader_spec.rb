describe ConfigLoader do

  let(:config_loader) { described_class.new filename: filename, stream: stream, stream_loader: stream_loader }
  let(:filename) { nil }
  let(:stream) { nil }
  let(:stream_loader) { nil }


  shared_examples_for 'a config reader' do

    it 'returns an object' do
      expect(config).to be_a Object
    end

  end


  describe 'config file locator' do
    let(:absolute_path) { '/blark' }
    let(:base_dir) { config_loader.send(:config_dir) }
    let(:expected_from_relative) { File.join( base_dir, relative_path) }
    let(:relative_path) { 'llama' }

    it 'returns an absolute path when given one' do
      expect( config_loader.send(:locate_config_file, absolute_path) ).to eq absolute_path
    end


    it 'returns the config dir when given a relative path' do
      expect( config_loader.send(:locate_config_file, relative_path) ).to eq expected_from_relative
    end

  end


  context 'with no stream or filename' do
    let(:filename) { nil }
    let(:stream) { nil }

    it 'explodes' do
      expect { config_loader.read }.to raise_error(described_class.const_get(:NoConfigError))
    end

  end


  context 'loading' do
    let(:config_hash) { YAML.load_file filename }
    let(:filename) { File.expand_path( File.join( File.dirname(__FILE__), '..', 'helpers', 'config.yml' ) ) }
    let(:stream) { StringIO.new(config_hash.to_yaml) }

    context 'from a YAML file' do
      let(:config) { described_class.new( filename: filename ).read  }
      it_behaves_like 'a config reader'
    end


    context 'from a stream' do
      let(:config) { described_class.new( stream: stream ).read  }
      it_behaves_like 'a config reader'
    end
  end

end
