#include "block.h"

block::block()
{
	activated = false;
}

void block::move()
{
	posX += velocityX;
	posY += velocityY;
	if(posX <= 0)
	{
		posX = -posX;
		velocityX = -velocityX;
	}
	if(posX >= sizeX-radius)
	{
		posX = 2*(sizeX-radius) - posX;
		velocityX = -velocityX;
	}
	if(posY <= 0)
	{
		posY = -posY;
		velocityY = -velocityY;
	}
	if(posY >= sizeY-radius)
	{
		posY = 2*(sizeY-radius) - posY;
		velocityY = -velocityY;
	}
}

void block::draw()
{
	nokia->drawrect(int(posX), int(posY), radius, radius, BLACK);
}

void block::init(int sizeX, int sizeY, PCD8544 *nokia)
{
	activated = true;
	posX = random(840)/10.0;
	posY = random(480)/10.0;
	velocityX = random(-10,10)/5.0;
	velocityY = random(-10,10)/5.0;
	radius = random(5,15);
	this->sizeX = sizeX;
	this->sizeY = sizeY;
}

bool block::getCollision(block target)
{
	return false;
}
