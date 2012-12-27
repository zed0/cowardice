#ifndef BLOCK_H
#define BLOCK_H

#include "PCD8544.h"

class block
{
	public:
		PCD8544 *nokia;
		float posX;
		float posY;
		int sizeX;
		int sizeY;
		float velocityX;
		float velocityY;
		int radius;
		int colour;
		bool activated;
		block();
		void move();
		void draw();
		void init(int sizeX, int sizeY, PCD8544 *nokia);
		bool getCollision(block target);
};

#endif
