require 'spec_helper'

describe PgRepack::Helper do
  subject(:helper) { PgRepack::Helper.new(node) }

  let(:node) { {
    'pg_repack' => {
      'version' => '5.4.3',
      'mirror' => 'https://github.com/reorg/pg_repack/archive',
      'checksum' => '11112222'
    }
  } }

  describe '#postgres_bindir' do
    it 'shells out to pg_config' do
      allow(helper).to receive(:shell_out!).and_return(double(stdout:"/path/to/pg/bin\n"))
      expect(helper.postgres_bindir).to eq('/path/to/pg/bin')
      expect(helper).to have_received(:shell_out!).with('pg_config --bindir')
    end
  end

  describe '#pg_repack_binary' do
    it 'is pg_repack in the postgres_bindir' do
      allow(helper).to receive(:postgres_bindir).and_return('/p/to/pg/bin')
      expect(helper.pg_repack_binary).to eq('/p/to/pg/bin/pg_repack')
    end
  end

  describe '#local_tarball' do
    it 'is the tarball_filename in the Chef file cache path' do
      expect(helper.local_tarball).to eq('/var/chef/cache/pg_repack_5.4.3.tar.gz')
    end
  end

  describe '#remote_source_tarball' do
    it 'defaults to github' do
      expect(helper.remote_source_tarball).to eq('https://github.com/reorg/pg_repack/archive/ver_5.4.3.tar.gz')
    end
  end

  describe '#tarball_checksum' do
    it 'is the node attribute' do
      expect(helper.tarball_checksum).to eq('11112222')
    end
  end

  describe '#tarball_filename' do
    it 'includes the version set in attributes' do
      expect(helper.tarball_filename).to eq('pg_repack_5.4.3.tar.gz')
    end
  end

  describe '#tarball_source_directory' do
    it 'includes the binary and version number' do
      expect(helper.tarball_source_directory).to eq('/var/chef/cache/pg_repack-ver_5.4.3')
    end
  end
end
