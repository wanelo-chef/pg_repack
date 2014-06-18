module PgRepack
  class Helper
    attr_reader :node

    def initialize(node)
      @node = node
    end

    def local_tarball
      File.join(Chef::Config[:file_cache_path], tarball_filename)
    end

    def remote_source_tarball
      File.join pg_repack_config['mirror'], remote_tarball_filename
    end

    def tarball_source_directory
      File.join Chef::Config[:file_cache_path], "pg_repack-ver_#{pg_repack_config['version']}"
    end

    def tarball_checksum
      pg_repack_config['checksum']
    end

    def tarball_filename
      "pg_repack_#{pg_repack_config['version']}.tar.gz"
    end

    private

    def remote_tarball_filename
      "ver_#{pg_repack_config['version']}.tar.gz"
    end

    def pg_repack_config
      node['pg_repack']
    end
  end
end
