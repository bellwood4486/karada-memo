relocateByYear = ->
  yearSelection = document.getElementById 'year'
  yearSelection.addEventListener 'change', ->
    Turbolinks.visit yearSelection.value

megabytesOf = (bytes) -> bytes / 1024 / 1024

checkNotePictureSize = ->
  document.getElementById('note_picture').addEventListener 'change', ->
    limit_in_mb = megabytesOf gon.picture_size_limit
    size_in_mb = megabytesOf this.files[0].size
    if (size_in_mb > limit_in_mb)
      # TODO 多言語対応が必要になったらi18n-jsを使って対応する
      alert("登録できる画像は#{limit_in_mb}MBまでです。サイズの小さい画像にしてください。");

onPageLoad 'notes#index', relocateByYear
onPageLoad 'notes#new', checkNotePictureSize
onPageLoad 'notes#edit', checkNotePictureSize
