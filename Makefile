# Emscripten build file

# Artifacts directory
BUILD_DIR=./build

# Compilers
CC=/mnt/c/projects/emsdk_linux/upstream/emscripten/emcc
CPP=/mnt/c/projects/emsdk_linux/upstream/emscripten/em++

# Default compiler flags
CFLAGS=-g0 -O3

# PhysFS

# Compiler flags
CFLAGS_PHYSFS=\
	-I./physfs \
	-s EMULATE_FUNCTION_POINTER_CASTS=1 \
	-DPHYSFS_SUPPORTS_DEFAULT=0 \
	-DPHYSFS_SUPPORTS_ZIP=1

# Sources
SOURCES_PHYSFS=\
	physfs/physfs.c \
	physfs/physfs_archiver_dir.c \
	physfs/physfs_archiver_unpacked.c \
	physfs/physfs_archiver_zip.c \
	physfs/physfs_byteorder.c \
	physfs/physfs_unicode.c \
	physfs/physfs_platform_posix.c \
	physfs/physfs_platform_unix.c \
	physfs/physfs_platform_windows.c

# Objects
OBJECTS_PHYSFS=$(SOURCES_PHYSFS:%=$(BUILD_DIR)/%.bc)

# TinyXML

# Compiler flags
CFLAGS_TINYXML=\
	-I./tinyxml

# Sources
SOURCES_TINYXML=\
	tinyxml/tinystr.cpp \
	tinyxml/tinyxml.cpp \
	tinyxml/tinyxmlerror.cpp \
	tinyxml/tinyxmlparser.cpp

# Objects
OBJECTS_TINYXML=$(SOURCES_TINYXML:%=$(BUILD_DIR)/%.bc)

# LodePNG

# Compiler flags
CFLAGS_LODEPNG=\
	-I./lodepng

# Sources
SOURCES_LODEPNG=\
	lodepng/lodepng.c

# Objects
OBJECTS_LODEPNG=$(SOURCES_LODEPNG:%=$(BUILD_DIR)/%.bc)

# VVVVVV

# Compiler flags
CFLAGS_VVVVVV=\
	-I./physfs \
	-I./lodepng \
	-I./tinyxml \
	-s USE_SDL=2 \
	-s USE_SDL_MIXER=2 \
	-s EMULATE_FUNCTION_POINTER_CASTS=1 \
	-DPHYSFS_SUPPORTS_DEFAULT=0 \
	-DPHYSFS_SUPPORTS_ZIP=1 \
	-DMAKEANDPLAY

# Linker flags
LDFLAGS_VVVVVV=\
	-s TOTAL_MEMORY=512MB \
	--preload-file ./data@/ \
	-s USE_SDL=2 \
	-s USE_SDL_MIXER=2 \
	-s EMULATE_FUNCTION_POINTER_CASTS=1 \
	-s TOTAL_STACK=128MB \
	-s USE_OGG=1 \
	-s USE_VORBIS=1

# Sources
SOURCES_VVVVVV=\
	src/BinaryBlob.cpp \
	src/BlockV.cpp \
	src/editor.cpp \
	src/Ent.cpp \
	src/Entity.cpp \
	src/FileSystemUtils.cpp \
	src/Finalclass.cpp \
	src/Game.cpp \
	src/Graphics.cpp \
	src/GraphicsResources.cpp \
	src/GraphicsUtil.cpp \
	src/Input.cpp \
	src/KeyPoll.cpp \
	src/Labclass.cpp \
	src/Logic.cpp \
	src/Map.cpp \
	src/Music.cpp \
	src/Otherlevel.cpp \
	src/preloader.cpp \
	src/Screen.cpp \
	src/Script.cpp \
	src/Scripts.cpp \
	src/SoundSystem.cpp \
	src/Spacestation2.cpp \
	src/TerminalScripts.cpp \
	src/Textbox.cpp \
	src/titlerender.cpp \
	src/Tower.cpp \
	src/UtilityClass.cpp \
	src/WarpClass.cpp \
	src/main.cpp \
	src/SteamNetwork.c

# Objects
OBJECTS_VVVVVV=$(SOURCES_VVVVVV:%=$(BUILD_DIR)/%.bc)

index.html: $(OBJECTS_VVVVVV) $(OBJECTS_PHYSFS) $(OBJECTS_TINYXML) $(OBJECTS_LODEPNG)
	$(CPP) $(CFLAGS) $(LDFLAGS_VVVVVV) $(OBJECTS_VVVVVV) $(OBJECTS_PHYSFS) $(OBJECTS_TINYXML) $(OBJECTS_LODEPNG) -o $(BUILD_DIR)/index.html --shell-file ./shell.html

$(OBJECTS_PHYSFS): $(BUILD_DIR)/%.bc: %
	mkdir -p build/physfs/
	$(CC) $(CFLAGS) $(CFLAGS_PHYSFS) -c $< -o $@

$(OBJECTS_TINYXML): $(BUILD_DIR)/%.bc: %
	mkdir -p build/tinyxml/
	$(CPP) $(CFLAGS) $(CFLAGS_TINYXML) -c $< -o $@

$(OBJECTS_LODEPNG): $(BUILD_DIR)/%.bc: %
	mkdir -p build/lodepng/
	$(CC) $(CFLAGS) $(CFLAGS_LODEPNG) -c $< -o $@

$(OBJECTS_VVVVVV): $(BUILD_DIR)/%.bc: %
	mkdir -p build/src/
	$(CPP) $(CFLAGS) $(CFLAGS_VVVVVV) -c $< -o $@
