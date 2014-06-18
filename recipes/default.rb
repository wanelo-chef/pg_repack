
helper = PgRepack::Helper.new(node)

remote_file helper.local_tarball do
  source helper.remote_source_tarball
end
