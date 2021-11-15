. ./PACKAGE.FS
. ./fsbuild/system.sh

cd fsbuild
rm -Rf _build
mkdir -p _build
cd ..

if [ "`uname`" = "Linux" ]; then
cd dist/linux
BUILD=0 PACKAGE=0 make
mv FS-UAE FS-UAE-3
mv \
	FS-UAE-3/$SYSTEM_OS/$SYSTEM_ARCH/fs-uae \
	FS-UAE-3/$SYSTEM_OS/$SYSTEM_ARCH/fs-uae-3
mv FS-UAE-3 ../../fsbuild/_build
cd ../..
elif [ "`uname`" = "Darwin" ]; then
cd dist/macos
SIGN=0 NOTARIZE=0 make plugin-no-archive
mv FS-UAE FS-UAE-3
mv \
	FS-UAE-3/$SYSTEM_OS/$SYSTEM_ARCH/FS-UAE.app \
	FS-UAE-3/$SYSTEM_OS/$SYSTEM_ARCH/FS-UAE-3.app
mv \
	FS-UAE-3/$SYSTEM_OS/$SYSTEM_ARCH/FS-UAE-3.app/Contents/MacOS/fs-uae \
	FS-UAE-3/$SYSTEM_OS/$SYSTEM_ARCH/FS-UAE-3.app/Contents/MacOS/fs-uae-3
mv FS-UAE-3 ../../fsbuild/_build
cd ../..
elif [ "`uname -o`" = "Msys" ]; then
cd dist/windows
make progdir
mv FS-UAE FS-UAE-3
mv \
	FS-UAE-3/$SYSTEM_OS/$SYSTEM_ARCH/fs-uae.exe \
	FS-UAE-3/$SYSTEM_OS/$SYSTEM_ARCH/fs-uae-3.exe
mv FS-UAE-3 ../../fsbuild/_build
cd ../..
fi

PLUGIN_DIR=fsbuild/_build/$PACKAGE_NAME_PRETTY

echo "[plugin]" > $PLUGIN_DIR/Plugin.ini
echo "name = $PACKAGE_NAME_PRETTY" >> $PLUGIN_DIR/Plugin.ini
echo "version = $PACKAGE_VERSION" >> $PLUGIN_DIR/Plugin.ini
unix2dos $PLUGIN_DIR/Plugin.ini
