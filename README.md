# docify-zip
> Zip with thor cli for docify.

## installation
```shell
npm i @feizheng/docify-zip
```

## usage
```shell
# debug
ruby src/index.rb zip MyPdf.pdf _test.com 123

# Have password/suffix
thor thor_cli:docify_zip:zip MyFiles _test.com 123123

# No password/suffix
thor thor_cli:docify_zip:zip MyFiles
```

## resources
- https://ma.ttias.be/create-a-password-protected-zip-file-on-mac-osx/
