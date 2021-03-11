# rodash (BETA)
[Lodash](https://lodash.com/docs/4.17.15) inspired [Brightscript](https://developer.roku.com/en-ca/docs/references/brightscript/language/brightscript-language-reference.md)/[ROPM](https://www.npmjs.com/package/ropm) ulitity for Roku apps


## Installation
### Using [ropm](https://www.npmjs.com/package/ropm)
```bash
ropm install rodash@npm:@tkss/rodash
```

## Usage Examples
### Chunk
```
rodash.chunk(["a", "b", "c", "d"], 2)
```
Returns: ["a", "b"], ["c", "d"]]

### Compact
```
rodash.compact([0, 1, false, 2, "", 3])
```
Returns: [1, 2, 3]

## Development

Currently in development
