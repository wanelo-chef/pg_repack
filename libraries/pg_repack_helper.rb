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
      File.join node['pg_repack']['mirror'], remote_tarball_filename
    end

    def tarball_filename
      "pg_repack_#{node['pg_repack']['version']}.tar.gz"
    end

    private

    def remote_tarball_filename
      "ver_#{node['pg_repack']['version']}.tar.gz"
    end
  end
end
