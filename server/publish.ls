Meteor.publish 'afFileFieldDoc', (collection-name, doc-id) ->
  check collection-name, String
  check doc-id, String

  collection = FS._collections[collectionName] or global[collectionName]
  if collection
    collection.find _id: doc-id
