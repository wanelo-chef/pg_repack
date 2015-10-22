require 'chef/mixin/shell_out'

class Chef
  class Provider
    # Resource for the pg_repack Chef provider
    #
    # This resource installs pg_repack into a postgres instance.
    #
    # pg_repack 'install pg_repack in 9.4' do
    #   postgres_bin_dir '/opt/local/postgres-9.4.5/bin'
    #   action :install
    # end
    #
    class PgRepack < Chef::Provider::LWRPBase
      include Chef::Mixin::ShellOut

      def load_current_resource
        @current_resource ||= new_resource.class.new(new_resource.name)
      end

      def action_install
        remote_file new_resource.local_tarball do
          source new_resource.remote_source_tarball
          checksum new_resource.tarball_checksum
        end

        execute 'untar pg_repack' do
          cwd ::File.dirname(new_resource.local_tarball)
          command "tar xzf #{new_resource.local_tarball}"
          not_if { ::File.directory?(new_resource.tarball_source_directory) }
        end

        execute 'make clean pg_repack' do
          cwd new_resource.tarball_source_directory
          command 'make clean'
          environment 'PATH' => new_resource.path
          not_if { ::File.exist?(new_resource.pg_repack_binary) }
        end

        execute 'make pg_repack' do
          cwd new_resource.tarball_source_directory
          command 'make'
          environment 'PATH' => new_resource.path
          not_if { ::File.exist?(new_resource.pg_repack_binary) }
        end

        execute 'make install pg_repack' do
          cwd new_resource.tarball_source_directory
          command 'make install'
          environment 'PATH' => new_resource.path
          not_if { ::File.exist?(new_resource.pg_repack_binary) }
        end
      end
    end
  end
end
