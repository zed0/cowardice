#ifndef PLAYER_H
#define PLAYER_H

#include "PCD8544.h"
#include "block.h"

class player
{
	public:
		PCD8544 *nokia;
		float posX;
		float posY;
		int sizeX;
		int sizeY;
		float velocity;
		int radius;
		int colour;
		player();
		void move();
		void draw();
		void init(int sizeX, int sizeY, PCD8544 *nokia);
		bool getCollision(block target);
};

#endif
