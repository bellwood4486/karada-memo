# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
# vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file. JavaScript code in this file should be added after the last require_* statement.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require rails-ujs
#= require activestorage
#= require turbolinks
#= require jquery3
#= require popper
#= require bootstrap-sprockets
#= require_self
#= require notes


# =====================================
# 共通処理
# =====================================

# 指定されたページのロード時にコールバックを呼び出す
# 例1(コントローラとアクションを指定)：
# onPageLoad 'posts#index', ->
#   # 処理
# 例2(コントローラのみ指定)
# onPageLoad 'posts', ->
#   # 処理
@onPageLoad = (controller_and_action, callback) ->
  registerCallback document, 'turbolinks:load', controller_and_action, callback

# 指定されたページの表示時にコールバックを呼び出す
# 例はonPageLoadと同じ
@onPageShow = (controller_and_action, callback) ->
  registerCallback window, 'pageshow', controller_and_action, callback

registerCallback = (eventHandler, eventType, controller_and_action, callback) ->
  unless typeof(controller_and_action) == 'string'
    console.error "registerCallback for [#{eventType}] Unexpected arguments!"
    return
  [controller, action] = controller_and_action.split('#')
  eventHandler.addEventListener eventType, ->
    callback() if isOnPage(controller, action)

isOnPage = (controller, action) ->
  selector = "body[data-controller='#{controller}']"
  selector += "[data-action='#{action}']" if action?
  document.querySelectorAll(selector).length > 0

