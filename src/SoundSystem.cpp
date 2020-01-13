#include <SDL.h>
#include <emscripten/em_asm.h>
#include "SoundSystem.h"
#include "FileSystemUtils.h"

MusicTrack::MusicTrack(void *mem, int size)
{
    m_isValid = true;

	EM_ASM({
        const mem = $0;
		const size = $1;

		console.log("Load music track", mem, size);

        const data = HEAP32.buffer.slice(mem, mem + size);

		Module.SDL2.audioContext.decodeAudioData(data).then(buffer => {
            window.musicTracks.push(buffer);
        });
	}, mem, size);
}

SoundTrack::SoundTrack(const char* fileName)
{
	sound = NULL;

	unsigned char *mem;
	size_t length = 0;
	FILESYSTEM_loadFileToMemory(fileName, &mem, &length);
	SDL_RWops *fileIn = SDL_RWFromMem(mem, length);
	sound = Mix_LoadWAV_RW(fileIn, 1);
	FILESYSTEM_freeMemory(&mem);

	if (sound == NULL)
	{
		fprintf(stderr, "Unable to load WAV file: %s\n", Mix_GetError());
	}
}

SoundSystem::SoundSystem()
{
	int audio_rate = 44100;
	Uint16 audio_format = AUDIO_S16SYS;
	int audio_channels = 2;
	int audio_buffers = 1024;

	if (Mix_OpenAudio(audio_rate, audio_format, audio_channels, audio_buffers) != 0)
	{
		fprintf(stderr, "Unable to initialize audio: %s\n", Mix_GetError());
		SDL_assert(0 && "Unable to initialize audio!");
	}
}

void SoundSystem::playMusic(MusicTrack* music)
{
	if(!music->m_isValid)
	{
		fprintf(stderr, "Invalid mix specified: %s\n", Mix_GetError());
	}

//	if(Mix_PlayMusic(music->m_music, 0) == -1)
//	{
//		fprintf(stderr, "Unable to play Ogg file: %s\n", Mix_GetError());
//	}
}
