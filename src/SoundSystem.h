#ifndef SOUNDSYSTEM_H
#define SOUNDSYSTEM_H

#include <SDL2/SDL_mixer.h>

class MusicTrack
{
public:
	MusicTrack(void *mem, int size);
	bool m_isValid;
};

class SoundTrack
{
public:
	SoundTrack(const char* fileName);
	Mix_Chunk *sound;
};

class SoundSystem
{
public:
	SoundSystem();
	void playMusic(MusicTrack* music);
};

#endif /* SOUNDSYSTEM_H */
