const fs = require('fs')
const mergeFiles = require('merge-files');
const glob = require('glob');
const concat = require("concat")
const copyfiles = require('copyfiles');


glob(__dirname + '/../.tmp/source/rodash/**/*.brs', {}, (err, files)=>{
  const outputDirectory = __dirname + '/../dist/source/';
  const outputPath = outputDirectory + 'rodash.brs';
  const inputPathList = files;

  fs.mkdir(outputDirectory, { recursive: true }, (err) => {
    if (err) throw err;

    concat(inputPathList).then((result) => {
      result = result.replace(/rodash_/g, '');
      result = result.replace(/^'import.*\n?/mg, '');

      fs.writeFile(outputPath, result, 'utf8', function (err) {
        if (err) return console.log(err);

        glob(__dirname + '/../.tmp/source/rodash/**/*.d.bs', {}, (err, files) => {
          var output = ""
          var outputs = {
            "rodash": ""
          }

          files.forEach((path) => {
            var fileName = path.split("/").pop();
            if (!fileName.includes("_")) {
              fs.readFile(path, 'utf8', function (err,data) {
                if (err) {
                  return console.log(err);
                }
                var result = data
                var hasNamespace = result.includes("namespace rodash.")

                if (hasNamespace) {
                  namespace = result.match(/.*namespace.*\n /g)[0].trim().replace("namespace rodash.", '');
                  if (outputs[namespace] === undefined) {
                    outputs[namespace] = "";
                  }

                  result = result.replace(/^.*namespace.*$/gm, '');
                  outputs[namespace] += result + "\n"

                } else {
                  result = result.replace(/^.*namespace.*$/gm, '');
                  outputs["rodash"] += result + "\n"
                }

              });
            }
          });

          setTimeout(function() {

            for (const [key, value] of Object.entries(outputs)) {
              console.log(`${key}`);
              if (key == "rodash") {
                output += value
              } else {
                output += "namespace " + key;
                output += value;
                output += "end namespace";
              }
            }

            fs.writeFile(outputDirectory + 'rodash.d.bs', output, 'utf8', function (err) {
              if (err) return console.log(err);
                console.log("rodash.d.bs created")
            });
          }, 250);
        })
      });
    })
  });
})
