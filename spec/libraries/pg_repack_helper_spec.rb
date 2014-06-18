require 'spec_helper'

describe PgRepack::Helper do
  subject(:helper) { PgRepack::Helper.new(node) }

  let(:node) { {
    'pg_repack' => {
      'version' => '5.4.3',
      'mirror' => 'https://github.com/reorg/pg_repack/archive'
    }
  } }

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

  describe '#tarball_filename' do
    it 'includes the version set in attributes' do
      expect(helper.tarball_filename).to eq('pg_repack_5.4.3.tar.gz')
    end
  end
end
