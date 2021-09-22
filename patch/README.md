## Patching a source file
`
# The ".patch" suffix is not required
$	diff -u <source-file> <new-source-file-with-fixes> ><diff4patchfile>.patch
$	patch <source-file> <diff4patchfile>.patch

