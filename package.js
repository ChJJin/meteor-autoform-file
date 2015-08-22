Package.describe({
  name: "chjjin:autoform-file",
  summary: "File upload for AutoForm",
  description: "File upload for AutoForm",
  version: "0.0.1",
  git: "https://github.com/ChJJin/meteor-autoform-file"
});

Package.onUse(function(api) {
  api.versionsFrom('METEOR@1.0');

  api.use([
    'jquery',
    'mquandalle:jade',
    'vasaka:livescript-compiler',
    'fourseven:scss',
    'reactive-var',
    'templating',
    'aldeed:autoform@5.3.2',
    'fortawesome:fontawesome@4.3.0'
  ]);

  //private package
  api.use('b-plus:form');

  api.addFiles([
    'client/autoform-file.jade',
    'client/autoform-file.ls',
    'client/autoform-file.sass'
  ], 'client');
  api.addFiles('server/publish.ls', 'server');
});
