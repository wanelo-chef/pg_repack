class Chef
  class Resource
    # Resource for the pg_repack Chef provider
    #
    # This resource installs pg_repack into a postgres instance.
    #
    # pg_repack 'install pg_repack in 9.4' do
    #   postgres_bin_dir '/opt/local/postgres-9.4.5/bin'
    #   action :install
    # end
    #
    class PgRepack < Chef::Resource
      include Chef::Mixin::ShellOut

      def initialize(name, run_context = nil)
        super
        @resource_name = :pg_repack
        @provider = Chef::Provider::PgRepack
        @action = :install
        @allowed_actions = [:install, :nothing]
      end

      def name(arg = nil)
        set_or_return(:name, arg, kind_of: String, required: true)
      end

      def postgres_bin_dir(arg = nil)
        set_or_return(:postgres_bin_dir, arg, kind_of: String)
      end

      def path
        [bin_dir, node['paths']['bin_path']].join(':')
      end

      def bin_dir
        postgres_bin_dir || shell_out!('pg_config --bindir', 'PATH' => node['paths']['bin_path']).stdout.strip
      end

      def local_tarball
        ::File.join(Chef::Config[:file_cache_path], tarball_filename)
      end

      def pg_repack_binary
        ::File.join postgres_bin_dir, 'pg_repack'
      end

      def remote_source_tarball
        ::File.join pg_repack_config['mirror'], remote_tarball_filename
      end

      def tarball_source_directory
        ::File.join Chef::Config[:file_cache_path], "pg_repack-ver_#{pg_repack_config['version']}"
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
end
