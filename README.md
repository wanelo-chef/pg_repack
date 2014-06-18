pg_repack Cookbook
==================

This cookbook installs the pg_repack postgres extension from github

## Depends

* [paths](https://github.com/bixu/paths)
* Postgres already being installed in `$PATH`


## Usage

Add the `pg_repack::default` recipe to a node.

This recipe depends on the `pg_config` binary existing in the PATH as
defined by `node['paths']['bin_path']`.


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github
