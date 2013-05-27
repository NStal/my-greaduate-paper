fs = require "fs"
path = require "path"
three = "./Threejs/build/three.js"
targetFile = "./common/three-node.js"
threeCode = fs.readFileSync(three).toString()

code= """
self = global
window = global
#{threeCode}
exports.THREE = THREE
exports.Three = THREE
"""
fs.writeFileSync(targetFile,code)
