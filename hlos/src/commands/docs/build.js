const {Command, flags} = require('@oclif/command')

class BuildCommand extends Command {
  async run() {
    const {flags} = this.parse(BuildCommand)
    const name = flags.name || 'world'
    this.log(`hello ${name} from /Users/kpoorman/src/HomelabOS/hlos/src/commands/docs/build.js`)
  }
}

BuildCommand.description = `Describe the command here
...
Extra documentation goes here
`

BuildCommand.flags = {
  name: flags.string({char: 'n', description: 'name to print'}),
}

module.exports = BuildCommand
