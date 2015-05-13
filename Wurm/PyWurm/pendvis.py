import pygame
import math
import numpy as np

clock = pygame.time.Clock()
pygame.init()
size = (width, height) = (600,500)
screen = pygame.display.set_mode(size)


class pendulum:
    def __init__(self):
	pass
    def draw(self):
        pygame.draw.circle(screen, (0,0,0), self.x0, 5)
        pygame.draw.line(screen, (0,0,0), self.x0, self.x.astype(int),3)
        pygame.draw.circle(screen, (0,0,255), self.x.astype(int), 14,0)
        pygame.draw.line(screen, (255, 0, 0), (self.x+200*self.a).astype(int), self.x.astype(int), 4)
dt = .001
g = [0,0.4]
p = pendulum(350,100,300,20)

j = 0
while 1:
    screen.fill((255,255,255))
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
    for i in range(100): # don't plot every timestep
        p.CalcForce()
        p.move()
        p.draw()
    clock.tick(60)
    pygame.display.flip()
    pygame.image.save(screen, "frame" + str(j) +".png")
    j = j+1
