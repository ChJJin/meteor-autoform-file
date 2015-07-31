Auto-form.add-input-type 'afFileField', do
  template: 'afFileField'
  value-out: -> @val!
  context-adjust: (context)->
    context.atts.label ?= '选择文件'
    context.atts.upload-label ?= '正在上传'
    context.atts.remove-label ?= '删除'
    context

Template.afFileField.on-created ->
  @value = new Reactive-var @data.value

  @collection = FS._collections[@data.atts.collection] or window[@data.atts.collection]
  @get-doc = ~>
    if @data.value and @value.get! is 0 # reset form后，要重新取data.value的值
      @value.set @data.value
    @collection?.find-one @value.get!

  @autorun !~> if id = @value.get!
    @subscribe 'afFileFieldDoc', @data.atts.collection, id

Template.afFileField.on-rendered ->
  $ @first-node .closest 'form' .on 'reset', ~> @value.set 0

Template.afFileField.helpers do
  dsk: -> 'data-schema-key': @atts['data-schema-key']
  file: -> Template.instance!get-doc!
  value: ->
    doc = Template.instance!get-doc!
    if doc?.is-uploaded! then doc._id
  previewTemplate: ->
    doc = Template.instance!get-doc!
    if doc?.is-image! then 'afFileFieldThumbImg' else 'afFileFieldThumbIcon'

Template.afFileField.events do
  'click .aff-select': (event, template)->
    template.$ '.aff-file' .click!

  'change .aff-file': (event, template)->
    file = new FS.File event.target.files[0]
    template.collection.insert file, (err, file-obj)!->
      if err then return console.warn err
      template.value.set file-obj._id

  'click .aff-remove': (event, template)->
    event.prevent-default!
    template.value.set null

Template.afFileFieldThumbIcon.helpers do
  icon: ->
    switch @extension()
    | 'pdf'                 =>  'file-pdf-o'
    | <[ doc docx]>         =>  'file-word-o'
    | <[ ppt avi mov mp4]>  =>  'file-powerpoint-o'
    | otherwise             =>  'file-o'
