# SpriteAtlasCutter

A quick and dirty command line tool to cut a PNG sprite atlas into separate sprite files.

The tool can be build using the terminal. Navigate to the root of the project and type `$ swift build`. A binary will be created at path `${PROJECT_DIR}/.build/debug/SpriteAtlasCutter`

The following parameters can be used on start-up:
- **-f** / **-file**: path to a sprite atlas file. Should be a PNG file.
- **-w** / **-width**: width of a single sprite in the atlas.
- **-h** / **-height**: of a single sprite in the atlas.

The tool will generate a list of numbered files based on the sprite atlas file name. E.g. if the sprite atlas file name is "hero.png", files like "hero_1.png", "hero_2.png", etc... would be generated.
