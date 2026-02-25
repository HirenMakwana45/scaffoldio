## 1.0.0

- Initial version.

## 0.0.1
- Initial release of ScaffoldIo.
- Added 'ecommerce' template (Kapda UI).
- Added support for future 'service' templates.

## 0.0.2
- Fixed process execution error in CLI.
- Added interactive terminal support for Mason prompts.
- Updated documentation and LICENSE.

## 0.0.3
- **Windows Support**: Added `runInShell` to resolve `ProcessException` on Windows systems.
- **Smart Scaffolding**: Integrated `-o .` logic to allow templates to be generated directly into existing project directories.
- **Conflict Management**: Added `--on-conflict overwrite` for a smoother, non-interruptive generation process.
- **Improved Messaging**: Clearer terminal feedback during the pulling and generation phases.

## 0.0.4
- **Fixed Flag Error**: Resolved "Could not find an option named --git-url" by restructuring the internal execution flow to use `mason add` correctly.
- **Improved Integration**: Templates are now registered via `mason add` before generation to ensure a clean local setup.
- **Workflow Optimization**: The CLI now handles the "Add then Make" process automatically, requiring zero manual configuration from the user.
- **Refined Merging**: Enhanced the `-o .` logic to ensure smoother merging with existing project structures.

## 0.0.5
- Implemented global brick execution to support zero-config project generation.

## 0.0.6
- Refined Mason global execution logic and fixed invalid flag error in make command

## 0.0.7
* Fixed dependency constraints for pub points.
* Added usage example.
* Improved documentation.

## 0.0.8
* Fixed args version to latest

## 0.0.9
* Refined the structure