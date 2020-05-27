# Boards preseeds

## Introduction

This repository holds various configuration preseeds for various project profiles for various boards.

These preseeds can be listed using:
```
make defconfig_list
```

Then, they can be loaded using:
```
make <defconfig_file_name>
```

The defconfig files must be saved into subdirectories corresponding to the target board name nomenclature,
as defined in the `CONFIG_BOARDNAME` variable. and a subdirectory named `proj_<projname>`, where projname
is named after the `CONFIG_PROJ_NAME` variable.

Using this, only preseed for current project on current board are visible using the defconfig list and
load targets.

## Keeping preseeds uptodate

With various new projects and features, preseeds may not be uptodate and requires regular updates.

This can be done manually, by loading each of them successively for each project profile. Though, there is
a little helper script, named `update_preseed.sh`, which help the preseed update operation, that can be used
to make the update step easier.

Though, the selection of the correct preseed for the corresponding working directory is under the responsability
of the maintainer. The `defconfig_list` target should be a first helper, making only the current board and current project
preseeds visibles.
