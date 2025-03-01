module example.com/main

go 1.22.2

replace example.com/hello => ../hello-module

require example.com/hello v0.0.0-00010101000000-000000000000
