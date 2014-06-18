
helper = PgRepack::Helper.new(node)

remote_file helper.local_tarball do
  source helper.remote_source_tarball
  checksum helper.tarball_checksum
end

execute "untar pg_repack" do
  cwd ::File.dirname(helper.local_tarball)
  command "tar xzf #{helper.local_tarball}"
  not_if { ::File.directory?(helper.tarball_source_directory) }
end

execute 'make pg_repack' do
  cwd helper.tarball_source_directory
  command 'make'
  environment 'PATH' => node['paths']['bin_path']
  not_if { ::File.exist?(helper.pg_repack_binary) }
end

execute 'make install pg_repack' do
  cwd helper.tarball_source_directory
  command 'make install'
  environment 'PATH' => node['paths']['bin_path']
  not_if { ::File.exist?(helper.pg_repack_binary) }
end
