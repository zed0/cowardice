#include "player.h"

player::player()
{
}

void player::move()
{
	int joystick = analogRead(A0);
	if(joystick <= 73)//left
	{
		posX-=velocity;
	}
	else if(joystick <= 245)//in
	{
	}
	else if(joystick <= 430)//down
	{
		posY+=velocity;
	}
	else if(joystick <= 624)//up
	{
		posY-=velocity;
	}
	else if(joystick <= 878)//right
	{
		posX+=velocity;
	}
	else//out
	{}

	if(posX <= 0)
	{
		posX = 0;
	}
	if(posX >= sizeX-radius)
	{
		posX = sizeX-radius;
	}
	if(posY <= 0)
	{
		posY = 0;
	}
	if(posY >= sizeY-radius)
	{
		posY = sizeY-radius;
	}
}

void player::draw()
{
	int drawX = posX>0?posX:0;
	int drawY = posY>0?posY:0;
	nokia->fillrect(drawX, drawY, radius, radius, BLACK);
}

void player::init(int sizeX, int sizeY, PCD8544 *nokia)
{
	this->sizeX = sizeX;
	this->sizeY = sizeY;
	posX = (sizeX-radius)/2.0;
	posY = (sizeY-radius)/2.0;
	velocity = 5.0;
	radius = 5;
}

bool player::getCollision(block target)
{
	bool collideX = ((posX+radius) > target.posX) && (posX < (target.posX + target.radius));
	bool collideY = ((posY+radius) > target.posY) && (posY < (target.posY + target.radius));
	if(collideX && collideY) return true;
	return false;
}
