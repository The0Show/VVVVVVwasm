BUILD_DIR=./build

CC=/mnt/c/projects/emskd_linux/upstream/emscripten/emcc
CPP=/mnt/c/projects/emskd_linux/upstream/emscripten/em++

CCFLAGS=-g4 -O2 -s ASSERTIONS=1

CCFLAGS_PHYSFS=-I./physfs -s EMULATE_FUNCTION_POINTER_CASTS=1 -DPHYSFS_SUPPORTS_DEFAULT=0 -DPHYSFS_SUPPORTS_ZIP=1
SOURCES_PHYSFS=physfs/physfs.c physfs/physfs_archiver_dir.c physfs/physfs_archiver_unpacked.c physfs/physfs_archiver_zip.c physfs/physfs_byteorder.c physfs/physfs_unicode.c physfs/physfs_platform_posix.c physfs/physfs_platform_unix.c physfs/physfs_platform_windows.c
OBJECTS_PHYSFS=$(SOURCES_PHYSFS:%=$(BUILD_DIR)/%.bc)

CCFLAGS_TINYXML=-I./tinyxml
SOURCES_TINYXML=tinyxml/tinystr.cpp tinyxml/tinyxml.cpp tinyxml/tinyxmlerror.cpp tinyxml/tinyxmlparser.cpp
OBJECTS_TINYXML=$(SOURCES_TINYXML:%=$(BUILD_DIR)/%.bc)

CCFLAGS_LODEPNG=-I./lodepng
SOURCES_LODEPNG=lodepng/lodepng.c
OBJECTS_LODEPNG=$(SOURCES_LODEPNG:%=$(BUILD_DIR)/%.bc)

CCFLAGS_VVVVVV=-I./physfs -I./lodepng -I./tinyxml -s USE_SDL=2 -s USE_SDL_MIXER=2 -s EMULATE_FUNCTION_POINTER_CASTS=1 -DPHYSFS_SUPPORTS_DEFAULT=0 -DPHYSFS_SUPPORTS_ZIP=1
LLFLAGS_VVVVVV=-s TOTAL_MEMORY=512MB --preload-file ./data@/ -s USE_SDL=2 -s USE_SDL_MIXER=2 -s EMULATE_FUNCTION_POINTER_CASTS=1 -s STACK_OVERFLOW_CHECK=2 -s TOTAL_STACK=256MB -s ALLOW_MEMORY_GROWTH=1 -s MAX_WEBGL_VERSION=2
SOURCES_VVVVVV=src/BinaryBlob.cpp src/BlockV.cpp src/editor.cpp src/Ent.cpp src/Entity.cpp src/FileSystemUtils.cpp src/Finalclass.cpp src/Game.cpp src/Graphics.cpp src/GraphicsResources.cpp src/GraphicsUtil.cpp src/Input.cpp src/KeyPoll.cpp src/Labclass.cpp src/Logic.cpp src/Map.cpp src/Music.cpp src/Otherlevel.cpp src/preloader.cpp src/Screen.cpp src/Script.cpp src/Scripts.cpp src/SoundSystem.cpp src/Spacestation2.cpp src/TerminalScripts.cpp src/Textbox.cpp src/titlerender.cpp src/Tower.cpp src/UtilityClass.cpp src/WarpClass.cpp src/main.cpp src/SteamNetwork.c
OBJECTS_VVVVVV=$(SOURCES_VVVVVV:%=$(BUILD_DIR)/%.bc)

index.html: $(OBJECTS_VVVVVV) $(OBJECTS_PHYSFS) $(OBJECTS_TINYXML) $(OBJECTS_LODEPNG)
	$(CPP) $(CCFLAGS) $(LLFLAGS_VVVVVV) $(OBJECTS_VVVVVV) $(OBJECTS_PHYSFS) $(OBJECTS_TINYXML) $(OBJECTS_LODEPNG) -o $(BUILD_DIR)/index.html

$(OBJECTS_PHYSFS): build/%.bc: %
	mkdir -p build/physfs/
	$(CC) $(CCFLAGS) $(CCFLAGS_PHYSFS) -c $< -o $@

$(OBJECTS_TINYXML): build/%.bc: %
	mkdir -p build/tinyxml/
	$(CPP) $(CCFLAGS) $(CCFLAGS_TINYXML) -c $< -o $@

$(OBJECTS_LODEPNG): build/%.bc: %
	mkdir -p build/lodepng/
	$(CC) $(CCFLAGS) $(CCFLAGS_LODEPNG) -c $< -o $@

$(OBJECTS_VVVVVV): build/%.bc: %
	mkdir -p build/src/
	$(CPP) $(CCFLAGS) $(CCFLAGS_VVVVVV) -c $< -o $@