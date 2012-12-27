#include "PCD8544.h"
#include "block.h"
#include "player.h"

// pin 13 - Serial clock out (SCLK)
// pin 11 - Serial data out (DIN)
// pin 08 - Data/Command select (D/C)
// pin 10 - LCD chip select (CS)
// pin 09 - LCD reset (RST)
PCD8544 nokia = PCD8544(13,11,8,10,9);
const int backLightPin = 7;
const int fps = 20;
int sizeX = LCDWIDTH;
int sizeY = LCDHEIGHT;
unsigned long startTime;
unsigned long survivalTime;
unsigned long bestSurvivalTime;
bool gameOverToggle;
unsigned long gameOverStart;
unsigned long survivalStart;

const int numblocks = 10;
int startBlocks = 3;
int currentNum = startBlocks;
unsigned long spawnCounter;
unsigned long spawnTime = 7 * 1000;
block blocks[numblocks];
player player1;

void setup(void)
{
	startTime = millis();
	survivalStart = millis();
	pinMode(backLightPin, OUTPUT);
	randomSeed(analogRead(1));
	player1.init(sizeX, sizeY, &nokia);
	digitalWrite(backLightPin, HIGH);
	nokia.init();
	nokia.setContrast(40);
	nokia.clear();
	nokia.setCursor(0,0);
	splash();
	reset();
}

void loop(void)
{
	nokia.clear();
	player1.move();
	player1.draw();
	bool collision = false;
	for(int i=0; i<numblocks; ++i)
	{
		if(blocks[i].activated)
		{
			if(!collision && player1.getCollision(blocks[i]))
			{
				collision = true;
			}
			blocks[i].move();
			blocks[i].draw();
		}
	}
	if(collision)
	{
		survivalTime = millis() - survivalStart;
		if(survivalTime > bestSurvivalTime)
		{
			bestSurvivalTime = survivalTime;
		}
		gameOver(survivalTime, bestSurvivalTime);
		reset();
	}
	if(millis() >= spawnCounter + spawnTime && currentNum < numblocks)
	{
		spawnBlock(currentNum++);
		spawnCounter = millis();
	}
	nokia.display();
	frame_wait();
}

void frame_wait()
{
	static unsigned long lastTime = 0;
	while(millis() - lastTime <= 1000/fps)
	{
		delay(1);
	}
	lastTime = millis();
}

void gameOver(unsigned long time, unsigned long bestTime)
{
	nokia.fillrect(8,8,64,28,WHITE);
	nokia.drawrect(8,8,64,28,BLACK);
	nokia.setCursor(10,10);
	nokia.println("Game over!");
	nokia.setCursor(18,18);
	nokia.println(String(time/1000) + "." + String(time%1000));
	nokia.setCursor(10,26);
	nokia.println("#1:" + String(bestTime/1000) + "." + String(bestTime%1000));
	nokia.display();
	delay(3*1000);
}

void splash()
{
	nokia.clear();
	nokia.fillrect(8,8,64,20,WHITE);
	nokia.drawrect(8,8,64,20,BLACK);
	nokia.setCursor(10,10);
	nokia.println("Avoid the");
	nokia.setCursor(20,18);
	nokia.println("blocks!");
	nokia.display();
	delay(3*1000);
}

void reset()
{
	currentNum = startBlocks;
	for(int i=0; i<numblocks; ++i)
	{
		if(i<startBlocks)
		{
			spawnBlock(i);
		}
		else
		{
			blocks[i].activated = false;
		}
	}
	survivalStart = millis();
	spawnCounter = millis();
}

void spawnBlock(int num)
{
	blocks[num].init(sizeX,sizeY,&nokia);
	while(player1.getCollision(blocks[num]))
	{
		blocks[num].init(sizeX,sizeY,&nokia);
	}
}
