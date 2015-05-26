

window.console = window.console || {}
window.console.log = window.console.log || (msg...)->
  log "LOG #{msg.join(", ")}"
  return

window.console.info = window.console.info || (msg...)->
  log "[0m[44m[37mINFO: [0m[0m #{msg.join(", ")}"
  return

window.console.warn = window.console.warn || (msg...)->
  log "[0m[43m[30mWARN: [0m[0m #{msg.join(", ")}"
  return

window.console.error = window.console.error || (msg...)->
  log "[0m[41m[37m[5mERROR:[0m[0m #{msg.join(", ")}"
  return

window.console.dir = window.console.dir || (obj)->
  log(JSON.stringify(obj, null, 4))
  return

window.console.assert = window.console.assert || (value, msg)->
  msg = "Assertion Failure: #{msg || ''}"
  unless value
    throw new Error msg
  return

window.require = (path)->
  console.assert path, "invalid path:#{path}"
  path = String(path)
  module = window["$_fakerequire_#{path}"]
  return module if module?

  originalPath = path
  if path.substr(-3,3) isnt ".js"
    path = path.replace(/\./g, '/')
    path = "src/#{path}.js"

  console.log "[window.require] hand to executeScript:#{path}"
  executeScript(path)
  return window["$_fakerequire_#{originalPath}"]

window.regRequire or= (path, module)->
  console.log "[regRequire] path:#{path}"
  console.assert path, "invalid path:#{path}"
  console.assert module, "invalid module:#{module}"
  path = "$_fakerequire_#{path}"
  if window[path]
    console.warn "ERROR [regRequire] already exist #{path}"
    return

  window[path] = module
  return



